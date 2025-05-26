import numpy as np
import pandas as pd
from scipy import stats
import matplotlib.pyplot as plt
from pathlib import Path
import glob

class MotionAnalyzer:
    def __init__(self, fd_threshold=0.2, dvars_threshold=None):
        self.fd_threshold = fd_threshold
        self.dvars_threshold = dvars_threshold
        
    def load_subject_data(self, fd_path, dvars_path):
        """
        Load FD and DVARS data from CSV files.
        
        Parameters:
        -----------
        fd_path : str or Path
            Path to the FD CSV file.
        dvars_path : str or Path
            Path to the DVARS CSV file.
            
        Returns:
        --------
        tuple
            (fd_data, dvars_data)
        """
        try:
            fd_data = pd.read_csv(fd_path).iloc[:, 1].values  
            dvars_data = pd.read_csv(dvars_path).iloc[:, 1].values
            
            return fd_data, dvars_data
        except Exception as e:
            print(f"Error loading data for subject: {e}")
            return None, None
    
    def analyze_subject(self, fd_data, dvars_data):
        """Analyze motion patterns for a single subject."""
        if self.dvars_threshold is None:
            dvars_mad = median_abs_deviation(dvars_data)
            self.dvars_threshold = dvars_mad * 2.5
        
        fd_outliers = fd_data > self.fd_threshold
        dvars_outliers = dvars_data > self.dvars_threshold
        both_outliers = fd_outliers & dvars_outliers
        
        results = {
            'fd_stats': {
                'mean': np.mean(fd_data),
                'max': np.max(fd_data),
                'std': np.std(fd_data),
                'n_outliers': np.sum(fd_outliers)
            },
            'dvars_stats': {
                'mean': np.mean(dvars_data),
                'max': np.max(dvars_data),
                'std': np.std(dvars_data),
                'n_outliers': np.sum(dvars_outliers)
            },
            'combined': {
                'n_both_outliers': np.sum(both_outliers),
                'correlation': np.corrcoef(fd_data, dvars_data)[0,1],
                'total_flagged_volumes': np.sum(fd_outliers | dvars_outliers)
            }
        }
        
        return results, (fd_outliers, dvars_outliers, both_outliers)

def process_directory(base_dir, fd_pattern="*_fd.csv", dvars_pattern="*_dvars.csv"):
    """
    Process all subjects in a directory.
    
    Parameters:
    -----------
    base_dir : str or Path
        Base directory containing motion files
    fd_pattern : str
        Glob pattern for FD files
    dvars_pattern : str
        Glob pattern for DVARS files
    
    Returns:
    --------
    tuple
        (group_results, problem_subjects, summary_df)
    """
    base_dir = Path(base_dir)
    analyzer = MotionAnalyzer()
    
    # Initialize results containers
    group_results = {}
    figures = {}
    
    # Find all subject files
    fd_files = sorted(base_dir.glob(fd_pattern))
    dvars_files = sorted(base_dir.glob(dvars_pattern))
    
    # Create mapping of subject IDs to file pairs
    subject_files = {}
    for fd_file in fd_files:
        subject_id = fd_file.stem.replace('_fd', '')
        matching_dvars = [f for f in dvars_files 
                         if f.stem.replace('_dvars', '') == subject_id]
        if matching_dvars:
            subject_files[subject_id] = (fd_file, matching_dvars[0])
    
    # Process each subject
    for subject_id, (fd_file, dvars_file) in subject_files.items():
        print(f"Processing subject {subject_id}...")
        
        # Load data
        fd_data, dvars_data = analyzer.load_subject_data(fd_file, dvars_file)
        if fd_data is None:
            continue
            
        # Analyze subject
        results, outliers = analyzer.analyze_subject(fd_data, dvars_data)
        group_results[subject_id] = results
        
        # Create visualization
        fig = plot_subject_data(fd_data, dvars_data, outliers, 
                              subject_id, analyzer)
        figures[subject_id] = fig
    
    # Create summary DataFrame
    summary_df = create_summary_df(group_results)
    
    # Identify problematic subjects
    problem_subjects = identify_problem_subjects(summary_df)
    
    return group_results, problem_subjects, summary_df, figures

def plot_subject_data(fd_data, dvars_data, outliers, subject_id, analyzer):
    """Create detailed plot for a subject."""
    fd_outliers, dvars_outliers, both_outliers = outliers
    
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(15, 8), sharex=True)
    
    # Plot FD
    ax1.plot(fd_data, 'b-', alpha=0.7, label='FD')
    ax1.plot(np.where(fd_outliers)[0], fd_data[fd_outliers], 
             'r.', label='Outliers')
    ax1.axhline(y=analyzer.fd_threshold, color='r', linestyle='--',
                label=f'Threshold ({analyzer.fd_threshold} mm)')
    ax1.set_ylabel('FD (mm)')
    ax1.legend()
    
    # Plot DVARS
    ax2.plot(dvars_data, 'g-', alpha=0.7, label='DVARS')
    ax2.plot(np.where(dvars_outliers)[0], dvars_data[dvars_outliers],
             'r.', label='Outliers')
    ax2.axhline(y=analyzer.dvars_threshold, color='r', linestyle='--',
                label=f'Threshold ({analyzer.dvars_threshold:.3f})')
    ax2.set_xlabel('Volume')
    ax2.set_ylabel('DVARS')
    ax2.legend()
    
    fig.suptitle(f'Subject {subject_id} Motion Analysis')
    plt.tight_layout()
    
    return fig

def create_summary_df(group_results):
    """Create summary DataFrame from group results."""
    summary_data = []
    
    for subject_id, results in group_results.items():
        summary_data.append({
            'Subject': subject_id,
            'Mean FD': results['fd_stats']['mean'],
            'Max FD': results['fd_stats']['max'],
            'FD Outliers': results['fd_stats']['n_outliers'],
            'Mean DVARS': results['dvars_stats']['mean'],
            'Max DVARS': results['dvars_stats']['max'],
            'DVARS Outliers': results['dvars_stats']['n_outliers'],
            'Both Outliers': results['combined']['n_both_outliers'],
            'FD-DVARS Correlation': results['combined']['correlation']
        })
    
    return pd.DataFrame(summary_data)

def identify_problem_subjects(summary_df, fd_thresh=20, dvars_thresh=20):
    """Identify subjects with excessive motion."""
    problem_mask = ((summary_df['FD Outliers'] > fd_thresh) | 
                   (summary_df['DVARS Outliers'] > dvars_thresh))
    return summary_df[problem_mask]

# Example usage:
"""
# Set your directory path
data_dir = "path/to/your/motion/files"

# Process all subjects
results, problems, summary, figs = process_directory(
    data_dir,
    fd_pattern="*_fd.csv",
    dvars_pattern="*_dvars.csv"
)

# Display summary statistics
print("\nSummary Statistics:")
print(summary.describe())

# Display problematic subjects
print("\nProblem Subjects:")
print(problems)

# Save figures
for subject_id, fig in figs.items():
    fig.savefig(f"{subject_id}_motion_analysis.png")
    plt.close(fig)
"""
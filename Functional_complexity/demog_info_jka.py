import os
import pandas as pd

# Change the current working directory to the specified path
#os.chdir('/Users/jolaneabrams/Desktop/NIIN/Jann_research/')

# Load the data from the Excel file
df_ndar_invs = pd.read_excel('/Users/jolaneabrams/Desktop/NIIN/Jann_research/KJ_Scripts/OCD_ABCD_324.xlsx',sheet_name='NDARINVs')
df_demographic_info = pd.read_excel('/Users/jolaneabrams/Desktop/NIIN/Jann_research/KJ_Scripts/ABCDdemoinfo_JKA.xlsx')


# Merge the NDARINVs and demographic info on the subject ID column
merged_df = pd.merge(df_ndar_invs, df_demographic_info[['The NDAR Global Unique Identifier', 'Sex', 'YPDS']], left_on='Subj ID', right_on='The NDAR Global Unique Identifier', how='left')


# Save the merged data to a new Excel file
merged_df.to_excel('merged_data.xlsx', index=False)
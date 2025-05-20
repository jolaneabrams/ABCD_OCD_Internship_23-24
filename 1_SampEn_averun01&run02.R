#This file is to average the NIFTI files across the scales and save the average files in a new folder with a new name

library("RNifti")
library("oro.nifti")
data=read.csv("/Volumes/Giant/ADHD_comorbidities/1194ids.csv")
subject=data[,1]

i=1 # subject index
while (i<=1194){
  print (i)
  filename1= paste("swusub",subject[i], "_r0.3_a1_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a1_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a1.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path) 

  
  filename1= paste("swusub",subject[i], "_r0.3_a2_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a2_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a2.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path) 
        
  filename1= paste("swusub",subject[i], "_r0.3_a3_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a3_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a3.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)   
  
  filename1= paste("swusub",subject[i], "_r0.3_a4_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a4_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a4.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path) 
  
  filename1= paste("swusub",subject[i], "_r0.3_a5_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a5_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a5.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a6_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a6_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a6.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a7_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a7_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a7.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a8_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a8_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a8.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a9_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a9_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a9.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a10_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a10_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a10.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)

  filename1= paste("swusub",subject[i], "_r0.3_a11_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a11_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a11.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a12_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a12_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a12.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a13_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a13_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a13.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a14_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a14_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a14.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
  
  filename1= paste("swusub",subject[i], "_r0.3_a15_run-01.nii", sep="")
  data_path1<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run01",filename1) 
  image1=readNifti(data_path1)
  
  filename2= paste("swusub",subject[i], "_r0.3_a15_run-02.nii", sep="")
  data_path2<-file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","run02",filename2) 
  image2=readNifti(data_path2)
  
  
  average_image=.5*(image1+image2)
  filename_new=paste(subject[i],"_r0.3_a15.nii",sep="")
  output_path=file.path("/Volumes", "Giant", "ADHD_comorbidities","complexity_undenoised_first5volumesremoved","ave_run1&run2",filename_new) 
  writeNifti(average_image, output_path)
    
        i= i+1
}
  



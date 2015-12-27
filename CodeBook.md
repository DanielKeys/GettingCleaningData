---
title: "CodeBook.md"
output: html_document
---

"Study design"
----------------------------------------------------------------------------

The raw data for this project comes from the prior study:

>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 

Information on that data is available at:
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names

And the entire data set used is available from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

My script does not use the "Inertial Signals" per conversations on the
forums:
https://class.coursera.org/getdata-035/forum/thread?thread_id=155#post-569

I read the other data (the X test and X train files) into R along with the subject id numbers for each row (in files named subject foo) and the column names (in features file) and the activity for each row (y test and y train).

I wondered what "measurement" meant, but eventually decided to look at just
the variables whose names included either "mean" or "std" per conversations on the forums: 
https://class.coursera.org/getdata-035/forum/thread?thread_id=183
and 
https://class.coursera.org/getdata-035/forum/thread?thread_id=155#comment-251
and also because I had even less clue what the "Mean" variables meant. I do
know they represent calculations performed on calculations and are certainly
not measurements. It's easy to say they don't matter to our "study".

In cleaning the data, I:


- Used cbind to stick subject and activity ids in front of X test,
- likewise X train
- then used rbind to stick the results together in a big table called "big", train data before test;
- subsetted the columns with the info I just added OR "mean" OR "std()", all of which went to the "medium" table
- replaced the numerical activity labels with the corresponding names from the file activity_labels
- put all variable names as.character and then in lower-case
- being confused by the fact that some variables names repeat the word "Body", I took that as a mistake and fixed it;
- expanded abbreviations to terms "acceleration", "frequency", "gyroscope", "standarddeviation", and "magnitude" (referring to Euclidean norm).
- Then removed parentheses;
- expanded "-X"" into "xaxissignal", and likewise for y and z.
- Then, removed "-" symbols;
- The "t" at the front of some variable names seems to convey no additional information - jerk and acceleration are typically defined with respect to time, we don't need to specify that - so I removed it;
- The "f" beginning some does tell us the mathematical process they come from, so I expanded it to "fastfouriertransform".

Finally, the output data:

- Through a silly but effective method involving rbind, I produced a "small" table containing the mean of each data variable from "medium" for each subject and activity.
- It was necessary to convert the result to a data frame (with numerical row names) using as.data.frame
- Each data variable was accurately named by pasting "meanof" before each "medium" title
- I wrote the small table to tidy.txt using write.table as ordered.

Code book
----------------------------------------------------------------------------

From the source, at
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names  :

- Features are normalized and bounded within [-1,1].
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.

(I think "seg" means second.)

Here is the complete list of column names in my final data set. Most are
self-explanatory. The subjectid is the ID number given to the subject from
which the data comes in the original study. Various data was recorded for 
each of the activities named in the second column; the summaries of this 
data have been given descriptive names (though some confusion might arise
from the use of all-lowercase; "meany" is part of "a mean taken from the 
Y-axis signal in the original study".) I won't explain these individually,
per the forum:
https://class.coursera.org/getdata-035/forum/thread?thread_id=183#comment-373
And the data is in "wide" form (which makes sense, as it still has many fewer variables than observations) as per:
https://class.coursera.org/getdata-035/forum/thread?thread_id=179#comment-324

 [1] "subjectid"                                                                 
 [2] "activity"                                                                  
 [3] "meanofbodyaccelerationmeanxaxissignal"                                     
 [4] "meanofbodyaccelerationmeanyaxissignal"                                     
 [5] "meanofbodyaccelerationmeanzaxissignal"                                     
 [6] "meanofbodyaccelerationstandarddeviationxaxissignal"                        
 [7] "meanofbodyaccelerationstandarddeviationyaxissignal"                        
 [8] "meanofbodyaccelerationstandarddeviationzaxissignal"                        
 [9] "meanofgravityaccelerationmeanxaxissignal"                                  
[10] "meanofgravityaccelerationmeanyaxissignal"                                  
[11] "meanofgravityaccelerationmeanzaxissignal"                                  
[12] "meanofgravityaccelerationstandarddeviationxaxissignal"                     
[13] "meanofgravityaccelerationstandarddeviationyaxissignal"                     
[14] "meanofgravityaccelerationstandarddeviationzaxissignal"                     
[15] "meanofbodyaccelerationjerkmeanxaxissignal"                                 
[16] "meanofbodyaccelerationjerkmeanyaxissignal"                                 
[17] "meanofbodyaccelerationjerkmeanzaxissignal"                                 
[18] "meanofbodyaccelerationjerkstandarddeviationxaxissignal"                    
[19] "meanofbodyaccelerationjerkstandarddeviationyaxissignal"                    
[20] "meanofbodyaccelerationjerkstandarddeviationzaxissignal"                    
[21] "meanofbodygyroscopemeanxaxissignal"                                        
[22] "meanofbodygyroscopemeanyaxissignal"                                        
[23] "meanofbodygyroscopemeanzaxissignal"                                        
[24] "meanofbodygyroscopestandarddeviationxaxissignal"                           
[25] "meanofbodygyroscopestandarddeviationyaxissignal"                           
[26] "meanofbodygyroscopestandarddeviationzaxissignal"                           
[27] "meanofbodygyroscopejerkmeanxaxissignal"                                    
[28] "meanofbodygyroscopejerkmeanyaxissignal"                                    
[29] "meanofbodygyroscopejerkmeanzaxissignal"                                    
[30] "meanofbodygyroscopejerkstandarddeviationxaxissignal"                       
[31] "meanofbodygyroscopejerkstandarddeviationyaxissignal"                       
[32] "meanofbodygyroscopejerkstandarddeviationzaxissignal"                       
[33] "meanofbodyaccelerationmagnitudemean"                                       
[34] "meanofbodyaccelerationmagnitudestandarddeviation"                          
[35] "meanofgravityaccelerationmagnitudemean"                                    
[36] "meanofgravityaccelerationmagnitudestandarddeviation"                       
[37] "meanofbodyaccelerationjerkmagnitudemean"                                   
[38] "meanofbodyaccelerationjerkmagnitudestandarddeviation"                      
[39] "meanofbodygyroscopemagnitudemean"                                          
[40] "meanofbodygyroscopemagnitudestandarddeviation"                             
[41] "meanofbodygyroscopejerkmagnitudemean"                                      
[42] "meanofbodygyroscopejerkmagnitudestandarddeviation"                         
[43] "meanoffastfouriertransformbodyaccelerationmeanxaxissignal"                 
[44] "meanoffastfouriertransformbodyaccelerationmeanyaxissignal"                 
[45] "meanoffastfouriertransformbodyaccelerationmeanzaxissignal"                 
[46] "meanoffastfouriertransformbodyaccelerationstandarddeviationxaxissignal"    
[47] "meanoffastfouriertransformbodyaccelerationstandarddeviationyaxissignal"    
[48] "meanoffastfouriertransformbodyaccelerationstandarddeviationzaxissignal"    
[49] "meanoffastfouriertransformbodyaccelerationmeanfrequencyxaxissignal"        
[50] "meanoffastfouriertransformbodyaccelerationmeanfrequencyyaxissignal"        
[51] "meanoffastfouriertransformbodyaccelerationmeanfrequencyzaxissignal"        
[52] "meanoffastfouriertransformbodyaccelerationjerkmeanxaxissignal"             
[53] "meanoffastfouriertransformbodyaccelerationjerkmeanyaxissignal"             
[54] "meanoffastfouriertransformbodyaccelerationjerkmeanzaxissignal"             
[55] "meanoffastfouriertransformbodyaccelerationjerkstandarddeviationxaxissignal"
[56] "meanoffastfouriertransformbodyaccelerationjerkstandarddeviationyaxissignal"
[57] "meanoffastfouriertransformbodyaccelerationjerkstandarddeviationzaxissignal"
[58] "meanoffastfouriertransformbodyaccelerationjerkmeanfrequencyxaxissignal"    
[59] "meanoffastfouriertransformbodyaccelerationjerkmeanfrequencyyaxissignal"    
[60] "meanoffastfouriertransformbodyaccelerationjerkmeanfrequencyzaxissignal"    
[61] "meanoffastfouriertransformbodygyroscopemeanxaxissignal"                    
[62] "meanoffastfouriertransformbodygyroscopemeanyaxissignal"                    
[63] "meanoffastfouriertransformbodygyroscopemeanzaxissignal"                    
[64] "meanoffastfouriertransformbodygyroscopestandarddeviationxaxissignal"       
[65] "meanoffastfouriertransformbodygyroscopestandarddeviationyaxissignal"       
[66] "meanoffastfouriertransformbodygyroscopestandarddeviationzaxissignal"       
[67] "meanoffastfouriertransformbodygyroscopemeanfrequencyxaxissignal"           
[68] "meanoffastfouriertransformbodygyroscopemeanfrequencyyaxissignal"           
[69] "meanoffastfouriertransformbodygyroscopemeanfrequencyzaxissignal"           
[70] "meanoffastfouriertransformbodyaccelerationmagnitudemean"                   
[71] "meanoffastfouriertransformbodyaccelerationmagnitudestandarddeviation"      
[72] "meanoffastfouriertransformbodyaccelerationmagnitudemeanfrequency"          
[73] "meanoffastfouriertransformbodyaccelerationjerkmagnitudemean"               
[74] "meanoffastfouriertransformbodyaccelerationjerkmagnitudestandarddeviation"  
[75] "meanoffastfouriertransformbodyaccelerationjerkmagnitudemeanfrequency"      
[76] "meanoffastfouriertransformbodygyroscopemagnitudemean"                      
[77] "meanoffastfouriertransformbodygyroscopemagnitudestandarddeviation"         
[78] "meanoffastfouriertransformbodygyroscopemagnitudemeanfrequency"             
[79] "meanoffastfouriertransformbodygyroscopejerkmagnitudemean"                  
[80] "meanoffastfouriertransformbodygyroscopejerkmagnitudestandarddeviation"     
[81] "meanoffastfouriertransformbodygyroscopejerkmagnitudemeanfrequency"      
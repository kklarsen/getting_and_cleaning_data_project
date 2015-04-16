# Code Book
### Course Project
#### Getting and Cleaning Data (getdata-013)
#### April 2015

This CodeBook provides the background for understanding how the `run_analysis.R` works.
The code does not contain any user defined functions and utilizes the standard packages of R.

The processed __Human Activity Registration__ (HAR) dataset is attributed to University of California, Irvine (UCI)  

The flow of the code follows naturally from Top to Bottom. However, explainatory comments breaks up the code in major functional segments as follows;

1. Unzip/install the UCI HAR Dataset to `"./UCI HAR Dataset"`. Unless the `"./UCI HAR Dataset" already exist in your working directory, __in which cases the code assumes that the datasets have been installed correctly__.
2. Create `"./results"` directory where intermediate and final text files can be written to.
3. Set UCI HAR dataset directories and file related constants.
4. Download and read the UCI HAR dataset files.


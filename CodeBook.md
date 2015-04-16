#Code Book
###Course Project
####Getting and Cleaning Data (getdata-013)
#####April 2015

#####INTRODUCTION
This CodeBook provides the background for understanding how the `run_analysis.R` works.
The code does not contain any user defined functions and utilizes the standard packages of R.

The processed __Human Activity Registration__ (__HAR__) dataset is attributed to [Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)belonging to the Center for Machine Learning and Intelligent Systems] at University of California, Irvine (__UCI__). This CodeBook refer to this dataset as
the "UCI HAR Dataset" or just __the data__.

The flow of the code follows naturally from Top to Bottom. However, explainatory comments breaks up the code in major functional segments as follows;

* Unzip/install the UCI HAR Dataset to `"./UCI HAR Dataset"`. Unless the `"./UCI HAR Dataset" already exist in your working directory, __in which cases the code assumes that the datasets have been installed correctly__.
* Create `"./results"` directory where intermediate and final text files can be written to.
* Define the data directories and file related constants.
* Download and read the data files.
* Data reshaping & tidying.
* Write the in the project specified tidy dataset `"tidy_mean&std.txt"`to `"./results"` directory.
  

#####RETRIEVE UCI HAR DATASET
  
Constant `uci.harDir` is set to `"./UCI HAR Dataset"` which is the directory that the zip-file would create in the working directory (i.e., getwd()) and extract the complete dataset to. All associated sub-directories and data files will 

If the `"./UCI HAR Dataset"` directory does not exist and thus result in the`file.exists()` logic turns `FALSE` (i.e., no such directory exists in the working directory), the UCI HAR zip-file containing the data will be unzipped.

`fileUrl`is defined as the UCI HAR Dataset zip-file as provided in the [Project](https://class.coursera.org/getdata-013/human_grading/view/courses/973500/assessments/3/submissions). The zip-file is unzipped, the UCI HAR Dataset directory structure created, datafiles extracted and finally the temporary external file is deleted (i.e., `unlink`).

The UCI HAR zip-file extraction will create the following directory structure (i.e., in your working directory);
* `"./UCI HAR Dataset"`
  *  `"./UCI HAR Dataset/test"`
  *  `"./UCI HAR Dataset/train"`
    
  __Note__: in both _test_ and _train_ subdirectories an additional directory is created names "Inertial Signals". For this project, the data stored in the "Inertial Signals" directories are not being used.

#####RESULT DIRECTORY
  
`resultsDir`defines the "results" directory `"./results"` in which intermediate and final results will be written to.`"./results`" will be created in the working directory.

`file.exist(results_dir)` logic checks whether directory already exist. If the directory does not exist `dir.create(results_dir)` will create the directory. If the directory `"./results"` already exist the code jumps over this step and continues.
  
#####CONSTANTS
  
This section associate constants with the various UCI HAR Datasets as follows;

* `activity.file` equals file path to and name of the dataset, i.e., `"activity_labels.txt"` to be found in `./"UCI HAR Dataset"`).
* `activity`is a `data.frame` containing the data from `"activity_labels.txt"` and contains to columns `"Label"` id and the associated 6 types of "measured" activity `"Activity"` (i.e., 1 WALKING, 2 WALKING UPSTAIRS 3 WALKING DOWNSTAIRS 4 SITTING 5 STANDING and 6 LAYING).
* `header.file` equals `"features.txt"`in `./"UCI HAR Dataset"`
* `headData`is the `data.frame` read from `"features.txt"`, and contains all measurements related to _Subject_ and _Activity_.

In the following _test/train_ simply means that the code is the same whether the file comes from the `"./UCI HAR Dataset/test"` or the `"./UCI HAR Dataset/train"` directories. In the code itself it is of course either _test_ or _train_.  

* `subj.test/trainFile` equals `"subject_test/train.txt"` that contains the Subject id (i.e., 1 to 30).
* `y.test/trainFile` equals `"y_test/train.txt"` that contains activity label id.
* `x.test/trainFile` equals `"x_test/train.txt"` containing all measurements identified by type in '"features.txt"`.
  
#####RETRIEVE THE DATA

#####DATA RESHAPING & TIDYING

#####WRITING PROJECT SPECIFIED TIDY FILE

#####AKNOWLEDGEMENT
___Reference___: [_Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013_.](https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf)

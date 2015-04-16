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


#####AKNOWLEDGEMENT
___Reference___: [_Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013_.](https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf)

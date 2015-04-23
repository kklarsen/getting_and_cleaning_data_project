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
* Write the in the project specified tidy dataset `"tidy.mean.txt"`to `"./results"` directory.
  

#####RETRIEVE UCI HAR DATASET
  
Constant `uci.harDir` is set to `"./UCI HAR Dataset"` which is the directory that the zip-file would create in the working directory (i.e., getwd()) and extract the complete dataset to. All associated sub-directories and data files will 

If the `"./UCI HAR Dataset"` directory does not exist and thus result in the`file.exists()` logic turns `FALSE` (i.e., no such directory exists in the working directory), the UCI HAR zip-file containing the data will be unzipped.

`fileUrl`is defined as the UCI HAR Dataset zip-file as provided in the [Project](https://class.coursera.org/getdata-013/human_grading/view/courses/973500/assessments/3/submissions). The zip-file is unzipped, the UCI HAR Dataset directory structure created, datafiles extracted and finally the temporary external file is deleted (i.e., `unlink`).

The UCI HAR zip-file extraction will create the following directory structure (i.e., in your working directory);
* `"./UCI HAR Dataset"`
  *  `"./UCI HAR Dataset/test"`
  *  `"./UCI HAR Dataset/train"`
    
  __Note__: in both _test_ and _train_ subdirectories an additional directory is created names "Inertial Signals". For this project, the data stored in the "Inertial Signals" directories are not being used.

#####DIMENSIONS & EXPECTATIONS

* 30 __Subjects__ under test (an observation).
* 6 different __Activities__ the above Subjects were subjected to (an observation).
* 561 different kind of measurements collected (the variables).
* 79 measurements are of the types __mean__ and __std__ (i.e., standard deviation).
* 10,299 (i.e., 2,947 from test & 7,352 from train data) __observations__, consisting of combinations of Subject & Subject's Activity.

Note using `distinct()`from the `dplyr` package (i.e., `library(dplyr)`) it can be shown that all 79 columns of __mean__ and __std__ are unique.

For the final tidy dataset result we should expect 81 columns (i.e., 2 + 79) consisting of 1 __Activity__ column, 1 __Subject__ column and 79 columns representing the unique __mean__ and __std__ meaurement variables. Further, with 30 subject's and 6 different kind of activities one should expect to see 180 rows of observations. 

#####RESULT DIRECTORY
  
`resultsDir`defines the "results" directory `"./results"` in which intermediate and final results will be written to.`"./results`" will be created in the working directory.

`file.exist(results_dir)` logic checks whether directory already exist. If the directory does not exist `dir.create(results_dir)` will create the directory. If the directory `"./results"` already exist the code jumps over this step and continues.
  
#####CONSTANTS & DEFINITIONS
  
This section associate constants with the various UCI HAR Datasets as follows;

* `activity.file` equals file path to and name of the dataset, i.e., `"activity_labels.txt"` to be found in `./"UCI HAR Dataset"`).
* `activity`is a `data.frame` containing the data from `"activity_labels.txt"` and contains to columns `"Label"` id and the associated 6 types of "measured" activity `"Activity"` (i.e., 1 WALKING, 2 WALKING UPSTAIRS 3 WALKING DOWNSTAIRS 4 SITTING 5 STANDING and 6 LAYING).
* `header.file` equals `"features.txt"`in `./"UCI HAR Dataset"`
* `headData`is the `data.frame` read from `"features.txt"`, and contains all measurement descriptions related to _Subject_ and _Activity_.

In the following _test/train_ simply means that the code is the same whether the file comes from the `"./UCI HAR Dataset/test"` or the `"./UCI HAR Dataset/train"` directories. In the code itself it is of course either _test_ or _train_.  

* `subj.test/trainFile` equals `"subject_test/train.txt"` that contains the Subject id (i.e., a total of 30 subjects).
* `y.test/trainFile` equals `"y_test/train.txt"` that contains activity label id.
* `x.test/trainFile` equals `"x_test/train.txt"` containing all measurements identified by type in `"features.txt"`.

__Note__: `y.test/trainFile` should be read as `y.testFile` or `y.trainFile`.
  
#####RETRIEVE THE DATA

In this section the various UCI HAR datafiles are being loaded. `read.table()` is used to read the data files with `header=FALSE` included. column names are defined right after the data has been read using the `names()` function(e.g., `names(subj.testData) <- "Subject"`).

* `subj.test/trainData` reads the measurement descriptions from `subj.test/trainFile` into a data frame (DF).
* `y.test/trainData` reads the activity (numeric) labels from `y.test/trainFile` into a DF.
* `x.test/trainData` reads the actual (numeric) measurements data from `x.test/trainFile` into a DF.

All `*Data` representing the content of the data are data frame formats. 
 
__Note__: `subj.test/trainData` should be read as `subj.testFile` or `subj.trainFile`.

#####DATA RESHAPING & TIDYING
My overall strategy with this part of the code, is to end up with one data frame containing all the information from the UCI HAR Datafile which uniquely identifies the measurement data (i.e., `"x.test/train.txt"`) with __Activity Measurement__ types (i.e., `"features.txt"`), __Subject id__ (i.e., `"subject_test/train.txt"`) and the specific activity carried out by the subject (i.e., `"y.test/train.txt"` and `"activity_labels.txt"`)

For most of the data reshaping the `"run_analysis.R"` code uses `rbind()` and `cbind()` functions, that combines a sequences of data frames by row or column, respectively.

* `x.test/trainData` uses `cbind()` to combine __Subject__ data column with the __Measurement__ data. Note that the element is being re-defined from only containing the __Measurement__ data to also including the __Subject id__ column.
* `x.data` uses `rbind()` to append `x.trainData` to the end of `x.testData` with the result of having a complete data frame containing the __Subject Ids__ and the associated activity __Measurements__.
* `y.data` uses `rbind()` to append `y.trainData` to the end of `y.testData` with the result of having a complete data frame containing the __Activity Ids__.
* `yx.data` uses `cbind()` to combine __Activity Ids__ data with the __Subject__ and __Measurement__ data
* `activityData` is a data frame that maps the given (numeric) activity id to the actual descriptive activity.
* `totalData'` uses `cbind()` to combine the descriptive activity data frame (i.e., `activityData`) with the `yx.data` data frame. Further, I need to re-name the added __Activity__ column in the `yx.data` to `Activity`.

In principle the `totalData` is a tidy data frame comprising the whole UCI HAR dataset. Following shows a subset/extract (i.e., 1:5 rows and 1:11 columns) of the `totalData` data frame;

![](http://i.imgur.com/h8abV2A.jpg)

Showing the first column as __Activity__, 2nd activity __Label__, 3rd the __Subject__ id, 4 - end are __Measurements__ corresponding to the Subject, Subjects Activity and the related activity Label.

#####DATA SUBSET ONLY CONTAINING MEAN & STANDARD DEVIATION (STD) MEASUREMENTS 

The Project assignment requires to extract the UCI HAR means and standard deviation measurements. For this part I have used the `grep(pattern, x, ignore.case=FALSE)` function which  searches in `x` elements matching the `pattern` (i.e., `"mean"` or `"std"`). __Note__ that `ignore.case` is `FALSE`. Thus, in this case, the ` grep()` function will only search for matching patterns in `LOWERCASE`. The reason is that there are other activity measurements that have "Mean" in their name-string (e.g., ` angle(tBodyAccMean,gravity)`). However those specific measurements are __NOT__ mean measurements but functional outputs (e.g., `angle()`) of a __mean__ measurement input (e.g., `tBodyAccMean`).

* `mean.col` are the column numbers of columns representing __mean__ measurements.
* `std.col` are the column numbers of columns representing standard deviation (i.e., __std__) measurements.  
* `mean.std.data` uses `cbind()` function to bind together the __mean__ data and __std__ data by referencing the `mean.col` and `std.col` numbers above in the `x.data` data frame.

The `mean.std.data` data frame is written to `"./results/mean_std_data.csv"` using the `write.csv()` function.

__Note__ as the assignment does require us to reference the mean & std with the actual __Activity__ (i.e., not to be confused with the __Activity id__) this part of the code operates on the `x.data` rather than on the `totalData`. Below find two subsets/extracts of this data;

![Shows the mean & std data for 1:5 rows and 1:8 columns. This data extract does not capture the standard deviation data as their column numbers are further out](http://i.imgur.com/C46oxiZ.png)

__Figure above__ shows the mean & std data for 1:5 rows and 1:8 columns. This data extract does not capture the standard deviation data as their column numbers are further out. The following picture does;

![Same data frame as above. Shows the mean & std data for 1:5 rows and 45:50 columns at the intersection between mean and std data columns.](http://i.imgur.com/eZw6Mqw.png)

__Figure above__ comes from the same data frame as above. This shows the mean & std data for 1:5 rows and 45:50 columns at the intersection between mean and std data columns.

* `mean.std.xtra` uses `cbind()` to add back __Subject__ id, numeric __Activity id__ and the descriptive __Activity__ identifier to the `mean.std.data` data frame.

The `mean.std.xtra` data frame is written to `"./results/mean_std_descriptive.csv"`. For comparison with the above two see the following extract;

![](http://i.imgur.com/L1m7CS5.png)   
__Figure above__ is similar to the two previous picture with exception of having __Activity__ characteristics, __Activity id__ and __Subject__ id added in the first 3 columns.

#####PROJECT SPECIFIED TIDY FILE

The final tidy data set, as required by the project, should take the mean of all _mean & standard deviation (i.e., std)_ __Measurement__ data for each __Subject__ and the subjects __Activity__. In other words, there should only be 1 row for each combination of __Activity__ and __Subject__. 

* `len` is the length of the `mean.std.xtra`.
* `tmsx` is the required data frame produced using the `aggregate(mean_std.xtra[],by = list(),mean)` function is very flexible in computing summary statistics of a pre-defined data subset. In this case, the subset is determined by the following grouping elements `mean.std.xtra$Subject`and `mean.std.xtra$Activity` which is added to `list()` and subject to statistical mean that is then applied to the subset.

I prefer that the first column of data is the __Activity__ type, followed by the __Subject__ id and then the computed mean summary of the __Measurement__ columns subset. Thus, I need to switch the 1st and 2nd column of `tmsx`.

* `tidy.mean`is the final tidy file as per this Projects requirement and looks the following for a small subset of overall tidy data frame (i.e., row 25 to 35 and column 1 to 6);

![](http://i.imgur.com/iFrjwT8.png)

Furthermore, the `tidy.mean` data frame is written to `"./results/tidy.mean.txt"`using the `write.table()` function with the argument `row.names = FALSE`.

`dim(tidy.mean)`gives us 180 rows (i.e., 6 activities for 30 unique subjects) and 81 columns (i.e., 1 for __Activity__, 1 for __Subject__ and 79 unique __mean__ + __std__ measurements columns) as explained in the __DIMENSIONS & EXPECTATIONS__ section above.

#####ACKNOWLEDGMENT
___Reference___: [_Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013_.](https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf)

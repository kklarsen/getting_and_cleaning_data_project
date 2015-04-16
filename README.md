# COURSE PROJECT
## Getting and Cleaning Data (getdata-013)
#### April 2015

This repo provides my R code solution to Coursera's "Getting & CLeaning Data" [Project](https://class.coursera.org/getdata-013/human_grading/view/courses/973500/assessments/3/submissions). The project is based on Smartphone datasets from UCI (University of California,Irvine) [Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) specificly measuring Human Activity by collecting data from sensors integrated in the Smartphone itself (i.e., [Samsung Galaxy II S](http://www.gsmarena.com/samsung_i9100_galaxy_s_ii-3621.php)). The dataset shall be known as UCI __HAR__ (UCI Human Activity Recognition) data or _just_ the data.

A prerequisite for succesully running the R code is that the [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) has been installed/unzipped on to your directory.

This repo contains one R-code script named `run_analysis.R`in line with the Project's requirements. The `run_analysis.R` code will do the following;

1. Reads the data.
2. Creates a "results" directory (`"./results"`) where intermediate or final results can be written to.
2. Consolidate all measurement data in 1 `data.frame`
3. Inserts explanatory measurement `headers` and corresponding variable `labels` (numeric as well as descriptive).
4. Extracting a sub-set of measurements.
5. Tidy the data-set (e.g., see also Hadley Wickham ["Tidy Data" article](http://vita.had.co.nz/papers/tidy-data.pdf)).
6. Several files are written to the "results" directory along the data tidying process.

__Note__: the requested final (tidy) file `tidy_mean&std.txt` can be found in the `"./results"` directory.

My `codebook.md` will in more detail explain the code's functionality.

___Reference___: [_Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013_.](https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf)



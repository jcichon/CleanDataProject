# CleanDataProject
This R script reads data tables, combines the rows together using rbind and then combines the columns together using cbind.
Once the data is merged, only the measurements for mean and standard deviation are selected.
Activity names are coded (1 - 6), and subject names are coded (1 - 30).  To make it more descriptive the features and acitiviy_labels tables are used to assign names to their codes.
The final product is a tidy data set grouped by mean and standard deviation measurements.

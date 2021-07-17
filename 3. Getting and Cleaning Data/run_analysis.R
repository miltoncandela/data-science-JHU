library(dplyr)

# establish the path of the folder
camino <- "UCI.HAR.Dataset"

# read and allocate the information
train_sub <- read.table(file.path(camino, "train", "subject_train.txt"))
train_val <- read.table(file.path(camino, "train", "X_train.txt"))
train_att <- read.table(file.path(camino, "train", "y_train.txt"))

teste_sub <- read.table(file.path(camino, "test", "subject_test.txt"))
teste_val <- read.table(file.path(camino, "test", "X_test.txt"))
teste_att <- read.table(file.path(camino, "test", "y_test.txt"))

names_col <- read.table(file.path(camino, "features.txt"), as.is = TRUE)


# 1. Merges the training and the test sets to create one data set.
toda <- rbind(cbind(train_sub, train_val, train_att), cbind(teste_sub,teste_val,teste_att))
colnames(toda) <- c("sujeto", names_col[,2], "actividad")

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std <- grepl("sujeto|mean|std|actividad", colnames(toda))
toda <- toda[,mean_std]

# 3. Uses descriptive activity names to name the activities in the data set
act_label <- read.table(file.path(camino, "activity_labels.txt"))
colnames(act_label) <- c("ID", "Activ")
toda$actividad <- factor(toda$actividad, levels = act_label[,1], labels = act_label[,2])

# 4. Appropriately labels the data set with descriptive variable names. 
nombres <- colnames(toda)

nombres <- gsub("[\\(\\)-]", "", nombres)
nombres <- gsub("^t", "time_", nombres)
nombres <- gsub("^f", "frequency_", nombres)
nombres <- gsub("mean", "_Mean", nombres)
nombres <- gsub("std", "_StandardDeviation", nombres)
nombres <- gsub("Acc", "Accelerometer", nombres)
nombres <- gsub("Gyro", "Gyroscope", nombres)
nombres <- gsub("Mag", "Magnitude", nombres)
nombres <- gsub("Freq", "Frequency", nombres)
nombres <- gsub("BodyBody", "Body", nombres)

colnames(toda) <- nombres

# 5. From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
todas <- as_tibble(toda)
todas <- group_by(todas,sujeto,actividad)
todas <- summarise_each(todas, funs(mean))

write.table(todas,"tidy_data.txt", row.name = FALSE)
library(dplyr)
library(tidyr)
feature_list <- read.table("features.txt", header = FALSE)
feature_list[,2] <- gsub("()", "_", feature_list[,2], fixed=TRUE)
feature_list[,2] <- gsub(",", "_", feature_list[,2], fixed=TRUE)
feature_list[,2] <- gsub("-", "", feature_list[,2], fixed=TRUE)
feature_list[,2] <- gsub("(", "", feature_list[,2], fixed=TRUE)
feature_list[,2] <- gsub(")", "", feature_list[,2], fixed=TRUE)
activity <- read.table("activity_labels.txt", header = FALSE)
names(activity) <- c("activity_id", "activity")
x<-bind_rows(
  (read.table("train/X_train.txt", header = FALSE) %>% tbl_df()),
  (read.table("test/X_test.txt", header = FALSE) %>% tbl_df())
)
names(x) <- feature_list[,2]
x<- x[,grepl("mean|std", names(x))]        
y<-bind_rows(
  (read.table("train/y_train.txt", header = FALSE) %>% tbl_df()),
  (read.table("test/y_test.txt", header = FALSE) %>% tbl_df())
)
names(y) <- "activity_id"
s<-bind_rows(
  (read.table("train/subject_train.txt", header = FALSE) %>% tbl_df()),
  (read.table("test/subject_test.txt", header = FALSE) %>% tbl_df())
)
names(s) <- "subject"
df <- bind_cols(s,y,x)
rm(s,y,x)
summarydf <- df %>%
  group_by(subject, activity_id) %>%
  summarize_each(funs(mean)) %>%
  merge.data.frame(activity, by.x = "activity_id", by.y = "activity_id", all = TRUE) %>%
  select(subject,activity, 3:81) %>%
  arrange(subject)
print(summarydf)
rm(df)
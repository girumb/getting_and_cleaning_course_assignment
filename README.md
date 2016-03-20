# getting_and_cleaning_course_assignment
Course assignment repo for the 'Getting and Cleaning Data' course
This Readme file describes the steps followed to apply the principles of tidy data lectured in the class.

R script steps for producing the tidy data:
===========================================
	1. Read the test and training data to perpare for the merge, using read.table function
	2. The database maintains the relationship between the entities, which should be extracted from the corresponding files 
	and merge/join
	To this effect, y_train.txt and y_test.txt should be read for their code values and the factor variable activity
	is looked up from activity_labels.txt
	3. After preparing and making consistent column agumentation, the merge between the 30% test data and 70% training data
	should happen
	4. Proper name for the merged activity info is needed for later ease 
    5. Extracting the mean and sd should idenity those data elements that contain the same and a number vector designating the columns should be extracted.
    7. Descriptive and appropriate labels should be assigned for each column in the data frame
    8. Among other options, I used the aggregate function for applying the group by on ActivityName and SubjectId 
    9. Finally the resulting dataframe have been written to the same working directory by file name 'activity_labels.txt'

The Code book for the final tidy data can be found in TidyCodeBook.md

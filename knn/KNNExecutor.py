import os
import pandas as pd
from sklearn.neighbors import NearestNeighbors
from sklearn import preprocessing
import numpy as np
import Configurations


class KNNExecutor:

    def executeKNN(self):
        training_df = pd.read_csv(os.path.join(Configurations.data_folder_name, Configurations.knn_training_file) + ".csv")
        print("Read in training file: " + str(training_df.shape))
        testing_df = pd.read_csv(os.path.join(Configurations.data_folder_name, Configurations.knn_testing_file) + ".csv")
        self.performKNN(training_df, testing_df, Configurations.knn_kvalue, Configurations.knn_columns_for_distance)


    def performKNN(self, training_df, testing_df, k, columns_to_use):
        """Perform the KNN algorithm on the testing data frame based on the training data frame selecting only the specified columns"""
        if training_df is not None and testing_df is not None and columns_to_use is not None and k > 0:

            print("Shape before drop: " + str((training_df.shape)))
            training_df = training_df.dropna(axis=0, how='any')
            print("Shape after drop: " + str((testing_df.shape)))

            training_values = training_df.loc[:, columns_to_use]
            testing_values = testing_df.loc[:, columns_to_use]

            # normalize the values between 0 and 1 if asked
            if Configurations.knn_should_scale_value:
                print("Scaling values")
                min_max_scaler = preprocessing.MinMaxScaler()
                training_values = min_max_scaler.fit_transform(training_values)
                testing_values = min_max_scaler.fit_transform(testing_values)

            nbrs = NearestNeighbors(n_neighbors = k, algorithm='ball_tree').fit(training_values)

            # Generate the nearest neighbors
            distances, indices = nbrs.kneighbors(testing_values)
            output = ""

            # Get the column names for the output file
            output = self.getColumnNames();

            for idx in range(0, len(indices)):
                output += self.getTextForOutput(testing_df[Configurations.knn_columns_to_select].iloc[idx])

                # get the filter value if present
                if Configurations.knn_filter_column_name:
                    filter_value_test = testing_df[Configurations.knn_filter_column_name].iloc[idx]
                print("Test filter values: " + filter_value_test)

                for neighbor in indices[idx]:
                    if Configurations.knn_filter_column_name:
                        filter_value_training = training_df[Configurations.knn_filter_column_name].iloc[neighbor]
                        print("Training filter values: " + filter_value_training)

                    output += self.getTextForOutput(training_df[Configurations.knn_columns_to_select].iloc[neighbor])

                output += "\n"

            # write the output to a file
            with open(Configurations.knn_output_file_name, "w") as file_handler:
                file_handler.write(output)

            print("Output file generated: " + Configurations.knn_output_file_name)

    def getTextForOutput(self, charity_details):
        text = ""
        if charity_details is not None:
            for column in Configurations.knn_columns_to_select:
                text += charity_details[column] + ","

        return text

    def getColumnNames(self):
        """Get the column names for the output file"""
        column_names = ""

        # Generate column names for the target from the test data
        for column in Configurations.knn_columns_to_select:
            column_names += "Target " + column + ","


        for itr in range(0, Configurations.knn_kvalue):
            for column in Configurations.knn_columns_to_select:
                column_names += "Neighbour " + str(itr + 1) + " " + column + ","

        column_names += "\n"
        return column_names

import pandas as pd

import Configurations
import os

class DataPreparer:

        def generate_combined_file(self):
            # Get the data frames
            data_frames = []

            for file_name in Configurations.file_names:
                print("Trying to read: {0}.csv".format(file_name))
                data_frames.append(pd.read_csv(os.path.join(Configurations.data_folder_name, file_name + ".csv")))
                print("Completed reading: {0}.csv".format(file_name))



            print("Trying to join the tables on uen now...")
            result_df = data_frames[0]
            for idx, df in enumerate(data_frames):
                if idx > 0:
                    result_df = result_df.merge(df, on = "uen")

            num_records = len(result_df.index)
            print("Number of records after joining: " + str(num_records))
            result_df.to_csv(Configurations.output_file_name)
            print("Written to file: {0}".format(Configurations.output_file_name))

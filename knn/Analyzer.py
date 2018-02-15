import pandas as pd

class Analyzer:
    def AnalyzeFile(self, file_name, identity_column_name):
        df = pd.read_csv(file_name)

        # total number of records
        total_records = len(df.index)

        print("Total number of records: {0}".format(str(total_records)))

        # number of unique IDs
        unique_msno = len(df[identity_column_name].unique())
        print("The number of records with unique msno: {0}".format(str(unique_msno)))

        print("Information of the data frame: ")
        print(df.info())

        print("Top 5 items in the data frame: ")
        print(df.head(5))

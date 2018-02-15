"""The client application to run the KNN algorithm"""
import sys

import Configurations
import DataPreparer
import KNNExecutor
import Analyzer


def main(args):
    """The main method"""
    print(args)
    if args and len(args) > 1:
        if "1" in args:
            preparer = DataPreparer.DataPreparer()
            preparer.generate_combined_file()
        if "2" in args:
            analyzer = Analyzer.Analyzer()
            analyzer.AnalyzeFile(Configurations.output_file_name, Configurations.identity_column_name)
    else:
        print("No argument specified and so nothing will be done. Thanks!")


if __name__ == "__main__":
    print("Please input: \n"
          "1. Generate output file from the input files\n"
          "2. Generate analysis from the generateed output \n"
          "while invoking the script\n")
    main(sys.argv)
# input file names without extensions (all CSV)
file_names = ["charities_with_ipc", "charities_financial_information"]

# output file name
output_file_name = "combined_charities.csv"

# identity column name across files
identity_column_name = "uen"

data_folder_name = "data"

knn_training_file = "training_charities_sizes"
knn_testing_file = "testing_charities_sizes"
knn_columns_for_distance = ["revenue", "receipts_others_income", "receipts_total"]
knn_kvalue = 5
knn_should_scale_value = True
knn_columns_to_select = ["name", "uen", "primary_sector","sub_setor"]
knn_output_file_name = "knn_output.csv"
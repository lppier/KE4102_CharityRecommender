# input file names without extensions (all CSV)
file_names = ["charities_with_ipc", "charities_financial_information"]

# output file name
output_file_name = "combined_charities.csv"

# identity column name across files
identity_column_name = "uen"

data_folder_name = "data"

knn_training_file = "training"
knn_testing_file = "testing"
knn_columns_for_distance = ["days_active", "compliance_score", "balance_assets_total","balance_funds_total", "balance_liabilities_total", "expenses_total", "receipts_total"]
knn_kvalue = 150
knn_should_scale_value = True
knn_columns_to_select = ["Name of Organisation", "UEN", "Sector","Classification"]
knn_output_file_name = "knn_output.csv"
knn_filter_column_name = ["Sector"]
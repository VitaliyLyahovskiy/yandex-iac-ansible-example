terraform {
  source = "github.com/patsevanton/terraform-yandex-storage-bucket.git//.?ref=main"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  bucket               = "velero"
  service_account_name = "s3-velero"
}

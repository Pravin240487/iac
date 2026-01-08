
variable "sftp_bucket_name" {
  default = "qs-stg-ec1-customer0007-s3-v1"
}
variable "customer_prefix" {
  default = "uploads/customer_master_data"
}
variable "sftp_customer0007_users" {
  type = list(string)
  default = [
    "Markus.Hauck@pfalzkom.de", "Daniel.Gumpert@pfalzkom.de", "Raphael.Redmer@talentship.io", "zacharias.doehmann@octonomy.ai"
  ]
}
variable "kms_key_arn" {
  default = "arn:aws:kms:eu-central-1:180294192430:key/10d353b1-9133-4f0b-80a9-cfb207d0f4db"
  type    = string

}
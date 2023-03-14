resource "random_string" "resource_code" {
  length  = 5
  numeric = true
  special = false
  upper   = false
  lower   = true
}

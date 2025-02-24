# provider "dns" {
#   update {
#     server        = "hover.com"
#     key_name      = "kallelilja-com."
#     key_algorithm = "hmac-md5"
#     key_secret    = var.dns_key_secret
#   }
# }

# resource "dns_a_record_set" "kallelilja-com" {
#   zone      = "kallelilja.com."
#   name      = "@"
#   addresses = var.dns_ghpages_a_records
#   ttl       = var.dns_default_ttl
# }

# resource "dns_aaaa_record_set" "kallelilja-com" {
#   zone      = "kallelilja.com."
#   name      = "@"
#   addresses = var.dns_ghpages_aaaa_records
#   ttl       = var.dns_default_ttl
# }

# resource "dns_cname_record" "www-kallelilja-com" {
#   zone  = "kallelilja.com."
#   name  = "www"
#   cname = "kallelilja.com."
#   ttl   = var.dns_default_ttl
# }

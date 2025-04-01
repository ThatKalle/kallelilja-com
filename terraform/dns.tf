# resource "dns_a_record_set" "kallelilja_com" {
#   zone      = "kallelilja.com."
#   name      = "@"
#   addresses = var.dns_ghpages_a_records
#   ttl       = var.dns_default_ttl
# }

# resource "dns_aaaa_record_set" "kallelilja_com" {
#   zone      = "kallelilja.com."
#   name      = "@"
#   addresses = var.dns_ghpages_aaaa_records
#   ttl       = var.dns_default_ttl
# }

# resource "dns_cname_record" "www_kallelilja_com" {
#   zone  = "kallelilja.com."
#   name  = "www"
#   cname = "thatkalle.github.io."
#   ttl   = var.dns_default_ttl
# }

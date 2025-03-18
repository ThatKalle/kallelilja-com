variable "branch_names" {
  description = "List of branch names"
  type        = set(string)
  default     = ["main"]
}

# variable "dns_key_secret" {
#   description = "A Base64-encoded string containing the shared secret to be used for TSIG."
#   type        = string
#   sensitive   = true

#   validation {
#     condition     = can(base64decode(var.dns_key_secret))
#     error_message = "The dns_key_secret value must be a valid Base64-encoded string."
#   }
# }

# variable "dns_default_ttl" {
#   description = "The TTL of the record."
#   type        = number
#   default     = 900
# }

# variable "dns_ghpages_a_records" {
#   description = "Github Pages A records."
#   type        = set(string)
#   default = [
#     "185.199.108.153",
#     "185.199.109.153",
#     "185.199.110.153",
#     "185.199.111.153"
#   ]
# }

# variable "dns_ghpages_aaaa_records" {
#   description = "Github Pages AAAA records."
#   type        = set(string)
#   default = [
#     "2606:50c0:8000::153",
#     "2606:50c0:8001::153",
#     "2606:50c0:8002::153",
#     "2606:50c0:8003::153"
#   ]
# }

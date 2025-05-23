variable "branch_names" {
  description = "List of branch names."
  type        = set(string)
  default     = ["main"]
}

variable "statuscake_default_statuscodes" {
  description = "List of StatusCake default status codes."
  type        = set(string)
  default     = ["202", "404", "405"]
}

variable "default_issue_labels" {
  description = "List of GitHub default issue labels."
  type = map(object({
    color       = string
    description = string
    name        = string
  }))

  default = {
    "documentation" = {
      color       = "0075ca"
      description = "Improvements or additions to documentation"
      name        = "documentation"
    },
    "help_wanted" = {
      color       = "008672"
      description = "Extra attention is needed"
      name        = "help wanted"
    },
    "good_first_issue" = {
      color       = "7057ff"
      description = "Good for newcomers"
      name        = "good first issue"
    },
    "enhancement" = {
      color       = "a2eeef"
      description = "New feature or request"
      name        = "enhancement"
    },
    "duplicate" = {
      color       = "cfd3d7"
      description = "This issue or pull request already exists"
      name        = "duplicate"
    },
    "bug" = {
      color       = "d73a4a"
      description = "Something isn't working"
      name        = "bug"
    },
    "question" = {
      color       = "d876e3"
      description = "Further information is requested"
      name        = "question"
    },
    "invalid" = {
      color       = "e4e669"
      description = "This doesn't seem right"
      name        = "invalid"
    },
    "wontfix" = {
      color       = "ffffff"
      description = "This will not be worked on"
      name        = "wontfix"
    }
  }
}

variable "dependabot_issue_labels" {
  description = "List of GitHub dependabot issue labels."
  type = map(object({
    color       = string
    description = string
    name        = string
  }))

  default = {
    "dependencies" = {
      color       = "0366d6"
      description = "Pull requests that update a dependency file"
      name        = "dependencies"
    }
  }
}

# variable "dns_key_secret" {
#   description = "A Base64-encoded string containing the shared secret to be used for TSIG."
#   type        = string
#   sensitive   = true

#   validation {
#     condition     = can(base64decode(var.dns_key_secret))
#     error_message = "The 'dns_key_secret' value must be a valid Base64-encoded string."
#   }
# }

# variable "dns_default_ttl" {
#   description = "The TTL of the record."
#   type        = number
#   default     = 3600

#   validation {
#     condition     = var.dns_default_ttl <= 604800
#     error_message = "The highest possible DNS TTL value is 604800 (7 days)."
#   }
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

#   validation {
#     condition = alltrue([
#       for ip in var.dns_ghpages_a_records : can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip))
#     ])
#     error_message = "All items in 'dns_ghpages_a_records' must be valid IPv4 addresses."
#   }
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

#   validation {
#     condition = alltrue([
#       for ip in var.dns_ghpages_aaaa_records : can(regex("^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$|^([0-9a-fA-F]{1,4}:){1,7}:$|^([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}$|^([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}$|^([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}$|^([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}$|^([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}$|^[0-9a-fA-F]{1,4}(:[0-9a-fA-F]{1,4}){1,6}$", ip))
#     ])
#     error_message = "All items in 'dns_ghpages_aaaa_records' must be valid IPv6 addresses."
#   }
# }

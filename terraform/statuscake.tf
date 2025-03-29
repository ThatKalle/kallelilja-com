
locals {
  statuscake_default_statuscodes = toset(flatten([
    [for i in range(204, 207) : tostring(i)], # 204-206
    ["303"],
    [for i in range(400, 402) : tostring(i)], # 400-401
    [for i in range(404, 411) : tostring(i)], # 400-411
    ["413", "429", "444"],
    [for i in range(494, 497) : tostring(i)], # 494-496
    [for i in range(499, 512) : tostring(i)], # 499-512
    [for i in range(520, 525) : tostring(i)], # 520-524
    [for i in range(598, 600) : tostring(i)], # 598-599
  ]))
}

resource "statuscake_uptime_check" "kallelilja_com" {
  name           = "kallelilja.com"
  check_interval = 900
  confirmation   = 2
  trigger_rate   = 10

  contact_groups = [
    data.statuscake_contact_group.kallelilja.id
  ]

  monitored_resource {
    address = "https://kallelilja.com"
    host    = "GitHub Pages"
  }

  http_check {
    enable_cookies   = false
    follow_redirects = false
    timeout          = 30
    user_agent       = "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/98 Safari/537.4 (StatusCake)"
    validate_ssl     = false

    status_codes = local.statuscake_default_statuscodes
  }

  tags = [
    "production",
    "terraform"
  ]
}

resource "statuscake_pagespeed_check" "kallelilja_com" {
  name           = "kallelilja.com"
  check_interval = 86400

  region = "DE"

  alert_config {
    alert_bigger  = 0
    alert_slower  = 0
    alert_smaller = 0
  }

  contact_groups = [
    data.statuscake_contact_group.kallelilja.id
  ]

  monitored_resource {
    address = "https://kallelilja.com"
  }
}

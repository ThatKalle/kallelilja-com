resource "github_repository" "kallelilja_com" {
  name         = "kallelilja-com"
  description  = "Personal site of Kallelilja"
  homepage_url = "https://kallelilja.com"
  visibility   = "public" #trivy:ignore:AVD-GIT-0001

  has_issues           = false
  has_wiki             = false
  has_projects         = false
  has_downloads        = false
  vulnerability_alerts = true

  allow_merge_commit          = true
  allow_rebase_merge          = true
  allow_squash_merge          = true
  allow_auto_merge            = true
  web_commit_signoff_required = true

  auto_init = false

  pages {
    build_type = "workflow"
    cname      = "kallelilja.com"
  }

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      # Without these the GITHUB_TOKEN needs contents:write permission.
      allow_auto_merge,
      allow_merge_commit,
      allow_rebase_merge,
      allow_squash_merge,
      merge_commit_message,
      merge_commit_title,
      squash_merge_commit_message,
      squash_merge_commit_title,
      pages[0].source
    ]
  }
}

resource "github_repository_topics" "repository_topics" {
  repository = github_repository.kallelilja_com.name

  topics = [
    "devcontainer",
    "terraformed",
    "hugo"
  ]
}

resource "github_branch" "branch" {
  for_each   = var.branch_names
  repository = github_repository.kallelilja_com.name
  branch     = each.key

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "default" {
  repository = github_repository.kallelilja_com.name
  branch     = github_branch.branch["main"].branch
}

resource "github_branch_protection" "branch_protection" {
  for_each      = var.branch_names
  repository_id = github_repository.kallelilja_com.node_id
  pattern       = each.key

  require_signed_commits = true

  required_status_checks {
    strict = true
    contexts = [
      "GitHub Actions CI",
      "HUGO CI",
      "Terraform CI",
    ]
  }
}

resource "github_actions_repository_permissions" "kallelilja_com" {
  repository = github_repository.kallelilja_com.name
  enabled    = true

  allowed_actions = "selected"

  allowed_actions_config {
    github_owned_allowed = true
    verified_allowed     = false
    patterns_allowed = [
      "advanced-security/filter-sarif@*",
      "aquasecurity/setup-trivy@*",
      "aquasecurity/trivy-action@*",
      "dependabot/fetch-metadata@*",
      "hashicorp/setup-terraform@*",
      "peaceiris/actions-hugo@*",
      "raven-actions/actionlint@*",
      "terraform-linters/setup-tflint@*"
    ]
  }
}

resource "github_repository_environment" "production" {
  repository  = github_repository.kallelilja_com.name
  environment = "production"

  can_admins_bypass = true

  reviewers {
    users = [data.github_user.thatkalle.id]
  }

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_deployment_branch_policy" "production" {
  repository       = github_repository.kallelilja_com.name
  environment_name = github_repository_environment.production.environment
  name             = "main"
}

resource "github_issue_label" "default_issue_labels" {
  for_each = var.default_issue_labels

  repository = github_repository.kallelilja_com.name

  color       = each.value.color
  description = each.value.description
  name        = replace(each.value.name, " ", "%20")
}

locals {
  dependabot_issue_labels = {
    "dependencies" = {
      color       = "0366d6"
      description = "Pull requests that update a dependency file"
      name        = "dependencies"
    },
    "devcontainers_package_manager" = {
      color       = "2753e3"
      description = "Pull requests that update devcontainers_package_manager code"
      name        = "devcontainers_package_manager"
    },
    "docker" = {
      color       = "1d63ed"
      description = "Pull requests that update docker code"
      name        = "docker"
    },
    "github_actions" = {
      color       = "2088ff"
      description = "Pull requests that update github_actions code"
      name        = "github_actions"
    },
    "terraform" = {
      color       = "734bb7"
      description = "Pull requests that update terraform code"
      name        = "terraform"
    }
  }
}

resource "github_issue_label" "dependabot_issue_labels" {
  for_each = merge(var.dependabot_issue_labels, local.dependabot_issue_labels)

  repository = github_repository.kallelilja_com.name

  color       = each.value.color
  description = each.value.description
  name        = each.value.name
}

resource "github_repository_dependabot_security_updates" "dependabot_security_updates" {
  repository = github_repository.kallelilja_com.name
  enabled    = true
}

resource "github_repository_file" "dependabot_yml" {
  repository          = github_repository.kallelilja_com.name
  branch              = github_branch_default.default.branch
  file                = ".github/dependabot.yml"
  content             = file("${path.module}/input/dependabot.yml")
  overwrite_on_create = true

  depends_on = [
    github_issue_label.dependabot_issue_labels["dependencies"],
    github_issue_label.dependabot_issue_labels["devcontainers_package_manager"],
    github_issue_label.dependabot_issue_labels["docker"],
    github_issue_label.dependabot_issue_labels["github_actions"],
    github_issue_label.dependabot_issue_labels["terraform"],
    github_repository_dependabot_security_updates.dependabot_security_updates
  ]
}

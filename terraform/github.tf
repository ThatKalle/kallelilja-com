provider "github" {
  token = var.tf_gh_token
  owner = "ThatKalle"
}

resource "github_repository" "kallelilja_com" {
  name         = "kallelilja-com"
  description  = "Personal site of Kallelilja"
  homepage_url = "https://kallelilja.com"
  visibility   = "public"

  has_issues   = false
  has_wiki     = false
  has_projects = false

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
  }
}

resource "github_repository_topics" "repository_topics" {
  repository = github_repository.kallelilja_com.name
  topics     = ["devcontainer", "terraformed", "hugo"]
}

resource "github_branch" "main" {
  repository = github_repository.kallelilja_com.name
  branch     = "main"
}

resource "github_branch_default" "default" {
  repository = github_repository.kallelilja_com.name
  branch     = github_branch.main.branch
}

resource "github_branch_protection" "branch_protection" {
  repository_id          = github_repository.kallelilja_com.name
  pattern                = "main"
  require_signed_commits = true
}

resource "github_repository_environment" "production" {
  environment       = "production"
  repository        = github_repository.kallelilja_com.name
  can_admins_bypass = true

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_deployment_branch_policy" "production" {
  depends_on = [
    github_repository_environment.production
  ]

  repository       = github_repository.kallelilja_com.name
  environment_name = github_repository_environment.production.environment
  name             = "main"
}

resource "github_actions_environment_variable" "ghpages_url_production" {
  repository    = github_repository.kallelilja_com.name
  environment   = github_repository_environment.production.environment
  variable_name = "ghpages_url"
  value         = "https://kallelilja.com"
}

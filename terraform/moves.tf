moved {
  from = github_branch.main
  to   = github_branch.branch["main"]
}

moved {
  from = github_branch_protection.branch_protection
  to   = github_branch_protection.branch_protection["main"]
}

import {
  for_each = var.default_issue_labels

  to = github_issue_label.default_issue_labels[each.key]
  id = "${github_repository.kallelilja_com.name}:${replace(each.key, "_", "%20")}"
}

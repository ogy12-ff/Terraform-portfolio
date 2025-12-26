# modules/iam_management/variables.tf

variable "group_policy" {
  description = "グループとそのポリシー設定のマップ。"
  type = map(object({
    policy_arns = list(string)
  }))
}

variable "user_to_group_map" {
  description = "ユーザー名と所属グループ名のマップ。"
  type        = map(string)
}

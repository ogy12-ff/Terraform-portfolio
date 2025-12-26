variable "group_policy" {
  description = "IAMグループとそのグループに割り当てるAWS管理ポリシーのARNを定義するマップ"
  type = map(object({
    policy_arns = list(string) #割り当てるAWS管理ポリシーのARNまたはカスタムポリシーのARN
  }))
  default = {
    "Developers" = {
      policy_arns = [
        "arn:aws:iam::aws:policy/ReadOnlyAccess",
        "arn:aws:iam::aws:policy/IAMUserChangePassword"
      ]
    },
    "Operators" = {
      policy_arns = [
        "arn:aws:iam::aws:policy/IAMUserChangePassword",
        "arn:aws:iam::aws:policy/AmazonS3FullAccess",
        "arn:aws:iam::aws:policy/CloudFrontReadOnlyAccess"
      ]
    },
    "Administrators" = {
      policy_arns = [
        "arn:aws:iam::aws:policy/AdministratorAccess"
      ]
    }
  }
}

variable "user_to_group_map" {
  description = "作成するIAMユーザーとそのユーザーが属するIAMグループを定義するマップ"
  type        = map(string)
  default = {
    "Developer_A"     = "Developers",
    "Developer_B"     = "Developers",
    "Operator_A"      = "Operators",
    "Administrator_A" = "Administrators"
  }
}

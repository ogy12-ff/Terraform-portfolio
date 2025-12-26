# ----------------------------------------------------
# ローカル変数の定義: データの整形
# ----------------------------------------------------
locals {
  # ユーザーをグループごとにまとめる
  group_users = { for group_name in keys(var.group_policy) : group_name => [
    for user_name, user_group in var.user_to_group_map : user_name if user_group == group_name
  ] }

  # ポリシーの関連付けを平坦化する
  policy_attachments = flatten([
    for group_name, group_info in var.group_policy : [
      for policy_arn in group_info.policy_arns : {
        group_name = group_name
        policy_arn = policy_arn
      }
    ]
  ])
}

# ----------------------------------------------------
# 1. IAMグループの作成
# ----------------------------------------------------
resource "aws_iam_group" "groups" {
  for_each = var.group_policy # group_policyのキー（グループ名）をループ
  name     = each.key
}

# ----------------------------------------------------
# 2. ポリシーのグループへの割り当て (アタッチ)
# ----------------------------------------------------
resource "aws_iam_group_policy_attachment" "policy_attachments" {
  for_each = {
    for attachment in local.policy_attachments :
    "${attachment.group_name}-${attachment.policy_arn}" => attachment
  }

  group      = aws_iam_group.groups[each.value.group_name].name
  policy_arn = each.value.policy_arn
}

# ----------------------------------------------------
# 3. IAMユーザーの作成
# ----------------------------------------------------
resource "aws_iam_user" "users" {
  for_each = var.user_to_group_map # user_to_group_mapのキー（ユーザー名）をループ
  name     = each.key
}


# ----------------------------------------------------
# 4. ユーザーのグループへの追加 (メンバーシップ)
# ----------------------------------------------------
resource "aws_iam_group_membership" "user_memberships" {
  for_each = local.group_users

  name  = "${each.key}-membership"
  group = aws_iam_group.groups[each.key].name
  users = [for user_name in each.value : aws_iam_user.users[user_name].name]
}

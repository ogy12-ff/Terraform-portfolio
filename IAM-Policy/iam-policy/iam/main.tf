module "iam" {
  source            = "../modules/iam"
  group_policy      = var.group_policy
  user_to_group_map = var.user_to_group_map
}

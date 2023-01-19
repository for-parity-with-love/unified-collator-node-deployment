data "aws_kms_alias" "kms_alias_eks_cluster" {
  name = "alias/${module.eks_cluster.eks_cluster_id}"
}

resource "aws_iam_policy" "cluster_kms_policy" {
  name        = "${local.environment}-${var.project_name}-kms-policy"
  description = "This policy fix cluster health-check-session AccessDenied error"
  path        = "/"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:DescribeKey",
                "kms:ListGrants"
            ],
          "Resource" : data.aws_kms_alias.kms_alias_eks_cluster.target_key_arn
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "cluster_kms_policy_attachment" {
  role       = module.eks_cluster.eks_cluster_id
  policy_arn = aws_iam_policy.cluster_kms_policy.arn
}

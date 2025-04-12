provider "aws" {
    region = "us-east-1"
}

resource "aws_iam_group" "system_admins" {
    name = "system_admins"
}

#Creating IAM USERS

resource "aws_iam_user" "system_admin_1" {
  name = "system_admin_1"
}

resource "aws_iam_user" "system_admin_2" {
  name = "system_admin_2"
}

resource "aws_iam_user" "system_admin_3" {
  name = "system_admin_3"
}


#adding the users to group 

resource "aws_iam_group_membership" "system_admins" {
    name = "system_admin_membership"

    users = [
        aws_iam_user.system_admin_1.name,
        aws_iam_user.system_admin_2.name,
        aws_iam_user.system_admin_3.name
    ]
    group = aws_iam_group.system_admins.name
}

resource "aws_iam_group_policy_attachment" "system_admin_policy" {
    group      = aws_iam_group.system_admins.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
} 

resource "aws_iam_user_login_profile" "system_admin_1" {
    user                    = aws_iam_user.system_admin_1.name
    password_reset_required = true
}

resource "aws_iam_user_login_profile" "system_admin_2" {
    user                    = aws_iam_user.system_admin_2.name
    password_reset_required = true
}

resource "aws_iam_user_login_profile" "system_admin_3" {
    user                    = aws_iam_user.system_admin_3.name
    password_reset_required = true
}

output "password" {
    value = aws_iam_user_login_profile.system_admin_1.password
    sensitive = true
}

resource "aws_iam_account_password_policy" "strict" {
    minimum_password_length        = 8
    require_lowercase_characters   = true
    require_numbers                = true
    require_uppercase_characters   = true
    require_symbols                = true
    allow_users_to_change_password = true
}
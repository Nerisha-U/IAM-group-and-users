provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_group" "developers" {
  name = var.developers
  path = "/users/"
}

//creating users
resource "aws_iam_user" "s3-users" {
  for_each = toset(var.users)
  name = each.value
}

/*resource "aws_iam_group" "my-group" {

    count = var.developers ? 1 : 0
    name = var.create_user
}   */

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = "aws_iam_group.developers"
  name  = var.name
  users = var.group_users
}

/*module "groups" {
 source = "./modules/groups-with-users"
 group = "developers"
 users = ["Nerisha","Brisha","Nishka"]
}

resource "aws_iam_group_membership" "group_attachment" {
  users = var.users
  group = aws_iam_group.developers.name
}*/

/*assigning users to group
resource "aws_iam_group_membership" "team-developers" {
  name = "developers"

  users = [ 
      "${aws_iam_user.user_one.name}",
      "${aws_iam_user.user_two.name}",
  ]
  group = "aws_iam_group.developers.name"
}

resource "aws_iam_group" "group" {
  name = "test-group"
}

resource "aws_iam_user" "user_one" {
  name = "test-user"
}

resource "aws_iam_user" "user_two" {
  name = "test-user-two"
}*/

//assigning policy to group 
resource "aws_iam_group_policy" "my_developer_policy" {
  name  = var.name
  group = "aws_iam_group.var.developers.id"


  policy = <<EOF
{
    "Version": "2015-02-06",
    "Statement": [
        {
           "Effect": "Allow",
            "Action": "iam:*",
            "Resource":"*"
    },
    {
      "Effect": "Allow",
      "Action": "s3:*",
    
        "Resource": "*"
        
        }
    ]
}
EOF
}


  /*assigning both IAM and s3 policy to group s3team
  policy = <<EOF
{
    "Version": "2015-02-06",
    "Statement": [
        {
           "Effect": "Allow",
            "Action": "iam:*",
            "Resource":"*"
    },
    {
      "Effect": "Allow",
      "Action": "s3:*",
    
        "Resource": "*"
        
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "my-test-policy" {
  name = "my-test-iam-policy"
  role = "aws_iam_role.my-test-iam-role.id"
}*/

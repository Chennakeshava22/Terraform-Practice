#groups

variable "group_name" {
type = map(string)
}

#users

variable "user_name" {
  type = map(string)
}


#group

resource "aws_iam_group" "group" {
for_each = var.group_name
name = each.value
}

#user

resource "aws_iam_user" "user" {
  for_each = var.user_name
  name = each.value
}


#attach users to the group.

variable "user_group" {
  type = map(string)
}


resource "aws_iam_user_group_membership" "group_user" {
  for_each =var.user_group
  user = each.key

  groups = [aws_iam_group.group[each.value].name]
}

#policy attachment
variable "policy_attach" {
  type = map(string)
}

# attaching policies.
resource "aws_iam_group_policy_attachment" "policy" {
  for_each = var.policy_attach
  group = aws_iam_group.group[each.key].name
  policy_arn = each.value
}

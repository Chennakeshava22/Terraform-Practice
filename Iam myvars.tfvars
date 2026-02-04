group_name = {
  dev  = "dev"
  prod = "prod"
  test = "test"
}


user_name = {
u1 = "ram"
u2 = "raju"
u3 = "keshava"
u4 = "reena"
u5 = "alia"
u6 = "suman"
}

user_group = {
ram = "dev"
raju = "prod"
keshava = "test"
alia = "test"
reena = "dev"
suman = "prod"
}


policy_attach = {
dev = "arn:aws:iam::aws:policy/AdministratorAccess-Amplify"
prod = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
test = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

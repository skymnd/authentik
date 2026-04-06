locals {
  group_memberships = {
    for g in keys(var.groups) : g => concat(
      [for k, u in authentik_user.admins : u.id if contains(var.admins[k].groups, g)],
      [for k, u in authentik_user.users : u.id if contains(var.users[k].groups, g)],
      [for k, u in authentik_user.service_accounts : u.id if contains(var.service_accounts[k].groups, g)]
    )
  }
}
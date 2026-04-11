locals {
  application_groups = {
    home       = "Available at home/through VPN"
    everywhere = "Available Everywhere"
  }


  group_memberships = {
    for group in keys(var.groups) : group => concat(
      [for key, user in authentik_user.admins : user.id if contains(var.admins[key].groups, group)],
      [for key, user in authentik_user.users : user.id if contains(var.users[key].groups, group)],
      [for key, user in authentik_user.service_accounts : user.id if contains(var.service_accounts[key].groups, group)],
    )
  }

  all_app_keys = toset(concat(keys(var.oauth2_providers), keys(var.proxy_providers)))

  application_users = {
    for app_key in local.all_app_keys : app_key => concat(
      [for key, user in authentik_user.admins : user.id if contains(var.admins[key].groups, app_key) || contains(var.admins[key].admin_groups, app_key)],
      [for key, user in authentik_user.users : user.id if contains(var.users[key].groups, app_key) || contains(var.users[key].admin_groups, app_key)],
      [for key, user in authentik_user.service_accounts : user.id if contains(var.service_accounts[key].groups, app_key) || contains(var.service_accounts[key].admin_groups, app_key)],
    )
  }

  application_admins = {
    for app_key in local.all_app_keys : app_key => concat(
      [for key, user in authentik_user.admins : user.id if contains(var.admins[key].admin_groups, app_key)],
      [for key, user in authentik_user.users : user.id if contains(var.users[key].admin_groups, app_key)],
      [for key, user in authentik_user.service_accounts : user.id if contains(var.service_accounts[key].admin_groups, app_key)],
    )
  }
}

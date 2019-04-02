output "cf_admin_password" {
  value       = "${random_string.CLUSTER_ADMIN_PASSWORD.result}"
  description = "The password to the CF admin account"
}

output "cf_api_endpoint" {
  value       = "https://api.${substr(google_dns_managed_zone.cf_zone.dns_name, 0, length(google_dns_managed_zone.cf_zone.dns_name) - 1)}"
  description = "The API endpoint used for cf logins"
}

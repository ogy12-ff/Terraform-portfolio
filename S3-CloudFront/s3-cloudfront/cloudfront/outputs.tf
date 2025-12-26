output "final_website_url" {
  description = "The public URL for the static website via CloudFront."
  value       = "https://${module.cdn.cloudfront_domain_name}"
}

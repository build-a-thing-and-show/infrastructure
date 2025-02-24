# infrastructure/main.tf

module "prod_environment" {
  source = "./environments/production"
}
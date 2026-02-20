locals {
  # Variáveis de controle de ambiente
  project     = "jpn"
  environment = ""

  common_tags = {
    Managed-by  = "terraform-${local.project}"
    Project     = local.project
    Department  = "TI"
    Owner       = "Empresa X"
    CreatedBy   = "Jose Neto"
    CostCenter  = "XPTO PROJECT"
    Backup      = "no"
    Lifecycle   = "permanent"
    Environment = local.environment
  }
}


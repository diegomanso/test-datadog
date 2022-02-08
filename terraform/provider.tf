terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "3.7.0"
    }
  }
}

provider "datadog" {
  # Configuration options
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://app.datadoghq.eu/"
}

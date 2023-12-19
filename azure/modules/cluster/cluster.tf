resource "azurerm_resource_group" "aks-demo" {
  name     = "aks-demo"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks-demo" {
  name                  = "aks-demo"
  location              = azurerm_resource_group.aks-demo.location
  resource_group_name   = azurerm_resource_group.aks-demo.name
  dns_prefix            = "aks-demo"
  kubernetes_version    =  var.kubernetes_version

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_a4_v2"
    type       = "VirtualMachineScaleSets"
    os_disk_size_gb = 250
  }

  service_principal  {
    client_id = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = var.ssh_key
    }
  }

  network_profile {
    network_plugin = "kubenet"
    load_balancer_sku = "standard"
  }

#  addon_profile {
#    aci_connector_linux {
#      enabled = false
#    }
#
#    azure_policy {
#      enabled = false
#    }
#
#    http_application_routing {
#      enabled = false
#    }
#
#    kube_dashboard {
#      enabled = false
#    }
#
#    oms_agent {
#      enabled = false
#    }
#  }

}
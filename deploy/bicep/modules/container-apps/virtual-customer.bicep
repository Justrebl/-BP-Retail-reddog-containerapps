param containerAppsEnvName string
param location string

resource cappsEnv 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: containerAppsEnvName
}

resource virtualCustomers 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'virtual-customers'
  location: location
  properties: {
    managedEnvironmentId: cappsEnv.id
    template: {
      containers: [
        {
          name: 'virtual-customers'
          image: 'ghcr.io/azure/reddog-retail-demo/reddog-retail-virtual-customers:latest'
        }
      ]
      scale: {
        minReplicas: 1
      }
    }
    configuration: {
      dapr: {
        enabled: true
        appId: 'virtual-customers'
        appProtocol: 'http'
      }
    }
  }
}

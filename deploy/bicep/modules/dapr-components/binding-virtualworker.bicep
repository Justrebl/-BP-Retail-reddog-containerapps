param containerAppsEnvName string

resource cappsEnv 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: containerAppsEnvName
}

resource daprComponent 'Microsoft.App/managedEnvironments/daprComponents@2022-03-01' = {
  name: 'orders'
  parent: cappsEnv
  properties: {
    componentType: 'bindings.cron'
    version: 'v1'
    metadata: [
      {
        name: 'schedule'
        value: '@every 15s'
      }
    ]
    scopes: [
      'virtual-worker'
    ]
  }
}

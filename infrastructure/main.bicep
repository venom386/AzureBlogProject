// Personal Blog Infrastructure - Phase 1
// Azure Static Web App with custom domain support

@description('Name of the static web app')
param staticWebAppName string = 'personal-blog-${uniqueString(resourceGroup().id)}'

@description('Location for resources')
param location string = resourceGroup().location

@description('SKU for the static web app')
@allowed([
  'Free'
  'Standard'
])
param sku string = 'Free'

@description('Repository URL (optional for manual deployment)')
param repositoryUrl string = ''

@description('Branch name for deployment')
param branch string = 'main'

@description('Build configuration')
param appLocation string = '/'
param apiLocation string = ''
param outputLocation string = 'dist'

// Static Web App resource
resource staticWebApp 'Microsoft.Web/staticSites@2022-09-01' = {
  name: staticWebAppName
  location: location
  sku: {
    name: sku
    tier: sku
  }
  properties: {
    repositoryUrl: repositoryUrl
    branch: branch
    buildProperties: {
      appLocation: appLocation
      apiLocation: apiLocation
      outputLocation: outputLocation
    }
    stagingEnvironmentPolicy: 'Enabled'
  }
}

// Output the static web app details (no secrets)
output staticWebAppName string = staticWebApp.name
output defaultHostname string = staticWebApp.properties.defaultHostname
output resourceId string = staticWebApp.id

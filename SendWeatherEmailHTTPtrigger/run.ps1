param($Request, $TriggerMetadata)

$weatherData = Invoke-RestMethod "https://api.darksky.net/forecast/$($env:weatherAPIKey)/40.7141667,-74.0063889"

$date = (Get-Date "1/1/1970").AddSeconds($weatherData.currently.time)

$result = @"
<table>
<tr><td>Date</td><td>$($date)</td></tr>
<tr><td>Location</td><td>$($weatherData.timezone)</td></tr>
<tr><td>Summary</td><td>$($weatherData.currently.summary)</td></tr>
<tr><td>Temperature</td><td>$($weatherData.currently.temperature)</td></tr>
<tr><td>FeelsLike</td><td>$($weatherData.currently.apparentTemperature)</td></tr>
<tr><td>ChanceOfRain</td><td>$($weatherData.currently.precipProbability)</td></tr>
<tr><td>WindSpeed</td><td>$($weatherData.currently.windSpeed)</td></tr>
<tr><td>Minute Summary</td><td>$($weatherData.minutely.summary)</td></tr>
<tr><td>Hour Summary</td><td>$($weatherData.hourly.summary)</td></tr>
<tr><td>Daily Summary</td><td>$($weatherData.Daily.summary)</td></tr>
</table>
"@

$SendGridPassword = ConvertTo-SecureString $env:SendGridPassword -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential $env:SendGridUsername, $SendGridPassword

$EmailFrom = "No-reply@azureadmin.com"
$EmailTo = "finked@hotmail.com"

$SMTPServer = "smtp.sendgrid.net"
$Subject = "The Weather for: $($date) "

Send-MailMessage `
    -smtpServer $SMTPServer `
    -Credential $credential `
    -Usessl `
    -Port 587 `
    -from $EmailFrom `
    -to $EmailTo `
    -subject $Subject `
    -Body $result `
    -BodyAsHtml

Push-OutputBinding -Name Response -Value @{
    StatusCode = "ok"
    Body       = "Ok"
}
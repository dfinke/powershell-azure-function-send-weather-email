# Powershell Azure Function Send Weather Email

[![Deploy to Azure](https://azuredeploy.net/deploybutton.svg)](https://azuredeploy.net/?repository=https://github.com/dfinke/powershell-azure-function-send-weather-email/tree/master)

# Setup

You need to setup some things to make this work.

- SendGrid - free tier, you need the `SendGridUsername` and `SendGridPassword`
    - Instructions
- Try for free https://darksky.net/dev, get the api key to set in the `weatherAPIKey`

Three settings in the applications settings for the azure function.

1. SendGridUsername
1. SendGridPassword
1. weatherAPIKey

**Note**: If you run this locally, set these in the `local.settings.json`.

In the `run.ps1`, you need change the latitude and longitude for you local weather.

```powershell
$weatherData = Invoke-RestMethod "https://api.darksky.net/forecast/$($env:weatherAPIKey)/40.7141667,-74.0063889"
```
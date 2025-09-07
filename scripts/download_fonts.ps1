# Create fonts directory if it doesn't exist
$fontsDir = "assets/fonts"
if (-not (Test-Path $fontsDir)) {
    New-Item -ItemType Directory -Path $fontsDir -Force | Out-Null
}

# Download Poppins font files
$fontWeights = @{
    "Poppins-Light.ttf" = "300"
    "Poppins-Regular.ttf" = "400"
    "Poppins-Medium.ttf" = "500"
    "Poppins-SemiBold.ttf" = "600"
    "Poppins-Bold.ttf" = "700"
}

$baseUrl = "https://github.com/google/fonts/raw/main/ofl/poppins/"

foreach ($font in $fontWeights.GetEnumerator()) {
    $fontFile = $font.Key
    $fontUrl = "${baseUrl}${fontFile}"
    $outputPath = Join-Path $fontsDir $fontFile
    
    Write-Host "Downloading $fontFile..."
    try {
        Invoke-WebRequest -Uri $fontUrl -OutFile $outputPath
        Write-Host "Downloaded $fontFile successfully" -ForegroundColor Green
    }
    catch {
        Write-Host ("Failed to download {0}: {1}" -f $fontFile, $_.Exception.Message) -ForegroundColor Red
    }
}

Write-Host "\nFont setup complete!" -ForegroundColor Green

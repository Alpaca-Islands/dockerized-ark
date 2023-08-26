c:\steamcmd\steamcmd.exe +force_install_dir c://arkserver +login anonymous +app_update 376030 +quit

$map = $env:MAP
$sessionName = $env:NAME
$adminPassword = $env:ADMIN_PASSWORD
$gamePort = $env:GAME_PORT
$queryPort = $env:QUERY_PORT
$maxPlayers = $env:MAX_PLAYERS
$rconEnabled = $env:RCON_ENABLED
$rconPort = $env:RCON_PORT
$extraStartupArgs = $env:EXTRA_STARTUPARGS

$parameters = "$($map)?listen?SessionName=`"$($sessionName)`"?ServerAdminPassword=$($adminPassword)?Port=$($gamePort)?QueryPort=$($queryPort)?MaxPlayers=$($maxPlayers)?RCONEnabled=$($rconEnabled)?RCONPort=$($rconPort)$($extraStartupArgs)"

Write-Host $parameters

Start-Process -FilePath C:\arkserver\ShooterGame\Binaries\Win64\ShooterGameServer.exe -ArgumentList $parameters -NoNewWindow

# rcon

# Define the path to rcon.exe
$rconPath = "C:/rcon/rcon-0.10.3-win64/rcon.exe"

# Define the partial output to wait for
$partialOutput = "Waiting commands for"

do {
    # Start the process with redirected standard output
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $rconPath
    $startInfo.Arguments = "-a 127.0.0.1:$($rconPort) -p $($adminPassword)"
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo
    $process.Start() | Out-Null

    # Read the process output
    $output = $process.StandardOutput.ReadToEnd()
    
    # Wait for the process to exit
    $process.WaitForExit()
    
    # Check if the partial output is found
    if ($output -match $partialOutput) {
        Write-Host "Server started!"
        break
    }
    
    # Sleep for a while before looping again
    Start-Sleep -Seconds 5
} while ($true)
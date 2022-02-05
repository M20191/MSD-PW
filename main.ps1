#M20191 4/2/2022


#Instaladores: Purpur, Spigot, Magma, Paper, Forge

# PURPUR # [1]1.18.1\n[2]1.17.1\n[3]1.16.5\n...
# Descarga (EULA,BAT)
# Inicio
# Cierre
# Cambio de RAM
# Instalar plugins
# Ping Server

# BAT,RAM
function ram_bat { 
    param (
    $ram = $( Write-Host "Ram del servidor en GB`n"
            Read-Host))

    $jar = "server.jar"
    "java -Xmx"+$ram+"G -Xms"+$ram+"G -jar "+$jar+" nogui`npause" | Out-File iniciar.bat
}

# Iniciar Server
function start_server
{
    iniciar.bat
}


# Bienvenida
function istart { 

Write-Host "
888b     d888  .d8888b.  8888888b.  Y88-888-888-888-888-888-888-888-88Y
8888b   d8888 d88P  Y88b 888  Y88b 
88888b.d88888 Y88b.      888    888            By: M20191
888Y88888P888  'Y888b.   888    888     
888 Y888P 888     'Y88b. 888    888     Minecraft Server Downloader 
888  Y8P  888       '888 888    888         Powershell Edition
888   '   888 Y88b  d88P 888  .d88P 
888       888  'Y8888P  8888888P    Y88-888-888-888-888-888-888-888-88Y 
"
}


# Descarga server
function download_server {
$choice = Read-Host "[1]Purpur [2]Paper [3]Spigot`n"

# Descarga PURPUR
if ($choice -eq 1) {
$VPurpur = ( "1.18.1",
             "1.17.1",
             "1.16.5"
            )

$VCPurpur = Read-Host "[0]1.18.1`n[1]1.17.1`n[2]1.16.5`n"  
$version = $VPurpur[$VCPurpur]
iwr -uri https://api.purpurmc.org/v2/purpur/$version/latest/download -OutFile server.jar -UseBasicParsing 

# Ram bat
ram_bat
}

# Descarga PAPER
elseif ($choice -eq 2){ 
$VPaper = (
            "1.18.1",
            "1.17.1"
           )    

$VCPaper = Read-Host "[0]1.18.1`n[1]1.17.1`n"
$version = $VPaper[$VCPaper]

#Version y build
$url = "https://papermc.io/api/v2/projects/paper/versions/$version/"
$json = iwr -uri $url -OutFile info.json -UseBasicParsing -ContentType "application/json"
$json = Get-Content ./info.json
$data = $json | ConvertFrom-Json
$build = $data.builds[-1]

# Name
$url = "https://papermc.io/api/v2/projects/paper/versions/$version/builds/"+$data.builds[-1] 
$json = iwr -uri $url -OutFile ./info.json -UseBasicParsing -ContentType "application/json"
$json = Get-Content ./info.json
$data = $json | ConvertFrom-Json

# Download NOW
$url = "https://papermc.io/api/v2/projects/paper/versions/$version/builds/"+$build+"/downloads/"+$data.downloads.application.name
iwr -uri $url -OutFile server.jar -UseBasicParsing

# Ram bat
ram_bat

}

# Descarga SPIGOT
elseif ($choice -eq 3) {
    $VSpigot = ("https://download.getbukkit.org/spigot/spigot-1.18.1.jar",
            "https://download.getbukkit.org/spigot/spigot-1.17.1.jar",
            "https://cdn.getbukkit.org/spigot/spigot-1.16.5.jar",
            "https://cdn.getbukkit.org/spigot/spigot-1.15.2.jar",
            "https://cdn.getbukkit.org/spigot/spigot-1.14.4.jar",
            "https://cdn.getbukkit.org/spigot/spigot-1.12.2.jar",
            "https://cdn.getbukkit.org/spigot/spigot-1.8.8-R0.1-SNAPSHOT-latest.jar
            ")
    $VCSpigot = Read-Host "[0]1.18.1`n[1]1.17.1`n[2]1.16.5`n[3]1.15.2`n[4]1.14.4`n[5]1.12.2`n[6]1.8.8"
    $version = $VSpigot[$VCSpigot]
    iwr -uri $version -OutFile server.jar -UseBasicParsing 

    #Ram bat 
    ram_bat

}
}
# MAIN
istart
$select = Read-Host "[1]Descargar Servidor`n[2]Iniciar Server`n[3]Cerrar Server`n[4]Cambiar Ram`n" 
if ($select -eq 1){
    download_server
}
elseif ($select -eq 2){
    start_server
}
elseif ($select -eq 3){
# Mantenimiento
}
elseif ($select -eq 4){
    ram_bat
}



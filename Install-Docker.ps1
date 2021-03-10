#https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/deploy-containers-on-server

# Run in PS as Admin
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Restart-Computer -Force

# If there is an issue with pulling from PSGallery
Uninstall-Module -Name PowerShellGet
Install-Module -Name PowerShellGet -Force
Update-Module -Name PowerShellGet
Exit

# Make Docker listen on an IP
dockerd --unregister-service
net stop docker
dockerd -H npipe:////./pipe/docker_engine -H 0.0.0.0:2375 --register-service
net start docker

# Install Base image
docker pull mcr.microsoft.com/windows/servercore:ltsc2019

# Install Team City Image (2019)
docker pull jetbrains/teamcity-agent:latest-windowsservercore

# Install Team City Image (2016)
docker pull jetbrains/teamcity-agent:2018.2.2-windowsservercore-ltsc2016

# Install choco
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Docker Compose
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\Docker\docker-compose.exe

# Setup TeamCity Dir
New-Item -Type Directory -Path C:\TeamCity
New-Item -Type Directory -Path C:\TeamCity\BuildAgents
New-Item -Type Directory -Path C:\TeamCity\BuildAgents\Agent-1






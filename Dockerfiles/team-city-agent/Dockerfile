FROM jetbrains/teamcity-agent:2018.2.2-windowsservercore-ltsc2016

# Use Powershell as the default shell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Chocolaty
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Download and install Python 2.7 + pip
RUN [Net.ServicePointManager]::SecurityProtocol = 'tls12, tls11, tls' ; \
    Invoke-WebRequest https://www.python.org/ftp/python/2.7.16/python-2.7.16.amd64.msi -OutFile python.msi ; \
    [Environment]::SetEnvironmentVariable('PYTHONIOENCODING', 'UTF-8', 'Machine') ; \
    $env:PYTHONIOENCODING='UTF-8' ; \
    Start-Process msiexec.exe -Wait -ArgumentList '/I python.msi /quiet' ; \
	Invoke-WebRequest https://bootstrap.pypa.io/pip/2.7/get-pip.py -OutFile get-pip.py; \
	C:\\Python27\\python.exe get-pip.py; \
	Remove-Item -Force get-pip.py; \
    Remove-Item -Force python.msi
	

# Install Python 2.7 Packages
RUN C:\\Python27\\Scripts\\pip2.7 install --no-cache-dir twine wheel

# Download and Install the VS 2017 Redistributables
#RUN choco install vcredist2017 --yes

# Download and Install the Oracle Client
RUN [Net.ServicePointManager]::SecurityProtocol = 'tls12, tls11, tls' ; \
    Invoke-WebRequest https://download.oracle.com/otn_software/nt/instantclient/191000/instantclient-basiclite-windows.x64-19.10.0.0.0dbru.zip \
    -OutFile instantclient-basiclite-windows.x64-19.10.0.0.0dbru.zip ; \
    New-Item -Type Directory -Path C:\\oracle ; \
    Expand-Archive instantclient-basiclite-windows.x64-19.10.0.0.0dbru.zip -DestinationPath C:\\oracle ; \
    Remove-Item -Force instantclient-basiclite-windows.x64-19.10.0.0.0dbru.zip ; \
    [Environment]::SetEnvironmentVariable('Path', $env:Path + 'C:\oracle\instantclient_19_10', 'Machine')

# Install the Artifactory JFrog CLI
RUN choco install jfrog-cli --yes

# Install the Docker CLI and Compose
RUN choco install docker-cli --yes

# escape=`
FROM docker.io/mralpacanl/unreal_gameserver_platform:ue-4.27.2

LABEL author="Jens van de Wiel" maintainer="jens.vdwiel@gmail.com"


#Add steamcmd
# Create SteamCMD directory
RUN New-Item -ItemType Directory "c:\steamcmd"

# Download and unpack SteamCMD archive
RUN Invoke-WebRequest http://media.steampowered.com/installer/steamcmd.zip -O c:\steamcmd\steamcmd.zip;
RUN Expand-Archive c:\steamcmd\steamcmd.zip -DestinationPath c:\steamcmd;
RUN Remove-Item c:\steamcmd\steamcmd.zip

# Update SteamCMD
RUN c:\steamcmd\steamcmd.exe +quit; exit 0

# Create the directory for rcon
RUN mkdir C:/rcon
# Download the rcon-cli release zip file
ADD https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-win64.zip C:/rcon/
# Unzip the downloaded zip file
RUN Expand-Archive -Path C:/rcon/rcon-0.10.3-win64.zip -DestinationPath C:/rcon/
RUN Remove-Item C:/rcon/rcon-0.10.3-win64.zip
#COPY rcon.ps1 C://rcon/rcon.ps1
#endregion rcon

# Env vars
ENV VALIDATE true

ENV QUERY_PORT      28016
ENV GAME_PORT       8888
ENV RAW_UDP_PORT    8889
ENV RCON_PORT       28020

ENV MAP             TheIsland
ENV NAME            Dockerized ark server on Windows!
ENV ADMIN_PASSWORD  test
ENV MAX_PLAYERS     10
ENV RCON_ENABLED    true

ENV EXTRA_STARTUPARGS ""



EXPOSE ${GAME_PORT}/tcp
EXPOSE ${GAME_PORT}/udp

EXPOSE ${QUERY_PORT}/tcp
EXPOSE ${QUERY_PORT}/udp


#rcon
EXPOSE ${RCON_PORT}/tcp
EXPOSE ${RCON_PORT}/udp


COPY entrypoint.ps1 c:\entrypoint.ps1

CMD ["powershell.exe", "C:\\entrypoint.ps1"]
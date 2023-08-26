# Dockerized ark container
### Watch out! this container is based on a windows image and thus only runs on windows docker
## Why
I have wanted to limit the memory usuage for my ark server , ark crashes if you limit the program itself, so docker is the way to go.
### Why an windows image
Ark has a plugin platform called Ark Server API, this only runs on windows.
If you won't use ARKServerAPI i recommend you to use: https://github.com/Hermsi1337/docker-ark-server this is a linux based container
#### Why don't use wine
The ark server executable needs certain dll's wich make wine unuseable. Normally this issue appears an a windows docker container too, this is because it needs directx and opengl too. This image uses another image wich adds this support to a small windows based container.
## How
To use pull the docker image and run the following:

    docker run -d --name my_ark_server -p 8888:8888/tcp -p 28016:28016/tcp -p 8888:8888/udp -p 28016:28016/udp -p 28020:28020/tcp -p 28020:28020/udp -v c:/arkserver:c:/arkserver --memory=10g ark-se-contained:latest
:warning: Make sure you set max memory, if you do not it will crash. Like: `--memory=10g`  :warning:
This starts the container witch updates/installs ark in c://arkserver it uses the default ports specified by the container and starts up the server. Because the ark server executeable is a gui program it does not show output to the console. To kind of fix this a rcon program is used, this displays when the server has started

### ⚠️ For all ports you should forward both tcp and udp ⚠️ 
##### If you can't join trough steam you should add it to your favorites and join from ark

### Env variables
|Variable name|Default value|
|--|--|
|`QUERY_PORT`|28016|
|`GAME_PORT`|8888|
|`RAW_UDP_PORT`|8889 (This sohuld always be GAME_PORT + 1)|
|`RCON_PORT`|28020|
|`MAP`|TheIsland|
|`NAME`|Dockerized ark server on Windows!|
|`ADMIN_PASSWORD`|test|
|`MAX_PLAYERS`|10|
|`RCON_ENABLED`|true (This should stay true because of the included rcon program)|
|`EXTRA_STARTUPARGS`||
`EXTRA_STARTUPARGS` starts empty, you can add any [startup commands](https://ark.fandom.com/wiki/Server_configuration#Command_line_arguments) to it :
### Minimum RAM

This server requires about 4096M to run with no players on a default map. Although it is recommended to run 6144M by the ARK creators, specific DLC maps will increase this requirement, such as Genesis 2 requiring over 13,440M to start.

See the following -  [https://ark.gamepedia.com/Dedicated_Server_Setup#Hardware](https://ark.gamepedia.com/Dedicated_Server_Setup#Hardware)

### RCON

The server requires a local RCON connection to function. You will see RCON connection refused messages until the server has successfully started and connects to the RCON, which can take anywhere from 10 to 20 minutes. The RCON Port is only required for external RCON connections. If you do not want to use rcon, just don't forward the port
## Contributing
Make a pull request and done!
## Thanks to

 - https://github.com/gorcon/rcon-cli
 - https://github.com/Hermsi1337/docker-ark-server



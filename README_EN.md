# rstudio_scrnaseq

## Simple Usage of scRNA-seq Analysis RStudio Server Docker

### [1] Starting a Container with `docker run`
Simply execute the following command in any location to start a container. If the Docker image is not downloaded, it will be downloaded and executed automatically. Once the download completes successfully, the container will start.

#### Running and Using the Container on Linux, WSL2, and Intel Mac

```bash
docker run --rm --name acctest -dit \
--mount type=bind,src=$PWD,dst=/home/rstudio \
-e USERID=$(id -u) \
-e GROUPID=$(id -g) \
-e PASSWORD="testpass" \
-p 8787:8787 \
hway/rstudio_scrnaseq
```

#### Running and Using the Container on M1/M2 Mac

```bash
docker run --rm --name acctest -dit \
--mount type=bind,src=$PWD,dst=/home/rstudio \
-e USERID=$(id -u) \
-e GROUPID=$(id -g) \
-e PASSWORD="testpass" \
-p 8787:8787 \
hway/rstudio_scrnaseq_arm64
```

#### Explanation of `docker run` Options and Customization Tips

- `--name acctest`: The container name (customizable).
- `--mount type=bind,src=$PWD,dst=/home/rstudio`: Specifies which parts of the host and container are shared. The directory where the command is executed (`$PWD`) is mapped to `/home/rstudio` in the container.
- `-e USERID=$(id -u)`: Ensures the same user ID between host and container.
- `-e GROUPID=$(id -g)`: Ensures the same group ID between host and container.
- `-e PASSWORD="testpass"`: "testpass" is arbitrary; set a custom password.
- `-p 8787:8787`: Port configuration (modifiable as `-p host_port:container_port`).
- `hway/rstudio_scrnaseq`: Specifies the desired Docker image (`hway/rstudio_scrnaseq_arm64` for M1/M2 Mac).

### [2] Accessing scRNA-seq Analysis RStudio Server
Once the container starts without errors, access the following URL in a web browser.

#### If the Container Runs on a Local PC  
```http://localhost:8787/```

- If the host port was changed from 8787 using the `-p` option in `docker run`, modify the port number after `:` in the URL accordingly.

#### If the Container Runs on a Remote Server  
```http://138.22.8.8:8787/```

- Replace `138.22.8.8` with the IP address of the server being used.
- If the host port was changed from 8787 using the `-p` option in `docker run`, modify the port number after `:` in the URL accordingly.

### [3] Logging into scRNA-seq Analysis RStudio Server

1. The RStudio Server login screen will appear.

2. Enter the following credentials to log in to RStudio Server:

```
username: rstudio
password: testpass # As specified in the `docker run` command above
```

3. RStudio is now ready to use.

### Other Docker Operations

* To check the status of running containers:

```bash
docker ps -a
```
If running, `acctest UP` should be displayed.

* To stop and remove a running container:

```bash
docker stop acctest      # Stops the running container
```

### RStudio Server Multi-User Configuration

This document explains the procedure for setting up RStudio Server within a Docker container for multi-user environments.

#### Prerequisites
- Docker must be installed on the host machine.
- RStudio Server container must be running.
- User information must be listed.

#### Steps to Add Multiple Users

##### 1. Access the Running Container
First, enter the RStudio Server container using the following command:

```sh
docker exec -it scrnaseq_handson /bin/bash
```

##### 2. Add Users Inside the Container
Execute the following command inside the container to create users from a pre-prepared user list:

```sh
newusers /home/rstudio/env/user_list.txt
```

**Note:** The `user_list.txt` file can be stored in any directory within the container.

##### 3. Exit the Container
After executing the user creation command, return to the host:

```sh
exit
```

#### User List Format
The `user_list.txt` file should contain user information in the following format:

```plaintext
<username>:<password>::::<home_directory>:/bin/bash
```

##### Example User List
```plaintext
user1:c5VGXTrh::::/home/rstudio/users/user1:/bin/bash
user2:Hg8P5FsL::::/home/rstudio/users/user2:/bin/bash
user3:n5WeQpf6::::/home/rstudio/users/user3:/bin/bash
user4:x2E5TSXP::::/home/rstudio/users/user4:/bin/bash
user5:wE7jNKfp::::/home/rstudio/users/user5:/bin/bash
```

Each username and password must be unique, and an appropriate home directory should be assigned.

#### Notes
- The `newusers` command creates multiple users from `user_list.txt` at once.
- Explicitly specify each user’s home directory to avoid conflicts.
- Be careful with password management and avoid storing passwords in public repositories.

By configuring these settings, multiple users will be able to use RStudio Server with their individual accounts.


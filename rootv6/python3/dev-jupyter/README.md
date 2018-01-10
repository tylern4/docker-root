# Jupyter in docker

I wanted a way to keep my python packages organized and working with [cern's ROOT](https://github.com/root-project/root), so I built jupyter to run on top of my rootv6 image. To run the image you can use:

```bash
docker run -p 9999:9999 -v$HOME/jupyter_notebooks:/home/jupyter/code --rm -d tylern4/jupyter:latest
```
This will start the notebook running as a daemon available at [https://your-local-ip:9999](https://localhost:9999), which will be available to any computer on the network. You can change this by adding the ` --NotebookApp.ip='127.0.0.1' ` option to the end if you only want to have the notebook availible on your local machine.

There is a default password of `jupyter` however this is also configurable by adding the
```
--NotebookApp.password='sha1:....'
``` 
option to the end of the command, where `'sha1:....'` comes from running the following command in a python terminal:

```python
from notebook.auth import passwd
passwd()
```

Just type in the password you want and copy the result.

I usually have mine setup in a bash/zsh function I put in my bashrc/zshrc and can run it whenever I want:

```bash

jupyter () {
  docker run \
    --name jupyter \
    -p 9999:9999 \
    -v/path/to/local/data/store:/mnt/Data \
    -v$HOME/jupyter_notebooks:/home/jupyter/code \
    --rm -d \
    tylern4/jupyter:latest \
    --NotebookApp.password='sha1:...';
}

```

## Credits:

A lot of the idea comes from [docker-stacks](https://github.com/jupyter/docker-stacks), but I needed a way to include ROOT in there as well.

I also have pulled a lot of ideas on building containers from [jessfraz/dockerfiles](https://github.com/jessfraz/dockerfiles).

# dasm-docker

Docker images for running dasm assembly compiler.

## Tags

 - **zshift/dasm**: dasm
 - **zshift/dasm:stella**: includes bundled stella for running Atari 2600 games compiled with dasm.
 - **zshift/dasm:stella-pulseaudio**: includes pulseaudio client for streaming audio. Necessary for receiving audio on mac.

## Running dasm



```bash
docker run --rm -it \
-v /path/to/asm/source:/home/dasm/src \
zshift/dasm SOME-ATARI-GAME.asm -oSOME-ATARI-GAME.bin -sSOME-ATARI-GAME.sym -f3
```

## Running Stella 

### Linux

#### Video

Can link to existing x-server with `-e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix` when running docker.

#### Sound

Can be piped in with `--device /dev/snd` when running docker.

#### Example Docker Command

```bash
docker run --rm -it \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--device /dev/snd \
-v /path/to/atari/bin:/home/stella \
zshift/dasm:stella SOME-ATARI-GAME.bin
```

### Mac

#### Video

Install XQuartz video server, `brew cask install XQuartz`, then run with `open -a XQuartz`.
In the XQuartz preferences, go to the "Security" tab,
and make sure you’ve got "Allow connections from network clients" ticked.
run xhost and allow connections from your local machine

```bash
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip
```

pass the arguments `-e DISPLAY=$ip:0 -v /tmp/.X11-unix:/tmp/.X11-unix` when running docker. 

[Guide](https://fredrikaverpil.github.io/2016/07/31/docker-for-mac-and-gui-applications/)

#### Sound

Must install PulseAudio sound server, `brew install pulseaudio`, 
then run the daemon with `pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon`.
When calling docker, use `-e PULSE_SERVER=docker.for.mac.localhost -v ~/.config/pulse:/home/2048/.config/pulse`.

[Guide](https://stackoverflow.com/a/50939994/1634430)

#### Example Docker Command

```bash
docker run --rm -it \
-e DISPLAY=$ip:0 \
-v /tmp/X11-unix:/tmp/X11-unix \
-e PULSE_SERVER=docker.for.mac.localhost \
-v ~/.config/pulse:/home/stella/.config/pulse \
-v /path/to/atari/bin:/home/stella \
zshift/dasm:stella-pulseaudio SOME-ATARI-GAME.bin
```

## License

[MIT](./LICENSE)
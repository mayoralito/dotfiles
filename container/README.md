# Apple's Container

More info at
https://github.com/apple/container and also https://www.bleepingcomputer.com/news/security/kali-linux-can-now-run-in-apple-containers-on-macos-systems/


## Basic usage

Start the configuration of your system:
```sh
container system start
```

Install kali linux
```sh
container run --rm -it kalilinux/kali-rolling
```

Mount a local directory into the Kali VM:
```sh
container run --remove --interactive --tty --volume $(pwd):/mnt --workdir /mnt docker.io/kalilinux/kali-rolling:latest
```



## Troubleshooting
If there is an issue that `container` cannot be found in the terminar. Uninstall it `brew uninstall --cask container` and then kill and launch the terminal and run the script `./script/bootstrap` again and it will ask for a password when it gets to the **container** installation.  After that it should work
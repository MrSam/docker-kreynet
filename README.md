[![N|Solid](http://www.krey.net/logo.jpg)](http://www.krey.net)

docker-kreynet is an unofficial docker testbox that helps during development.

  - IPv6 Support
  - OpenSSL support
  - Magic

### Installation

This project requires [Docker](https://www.docker.com/), install Docker first and then continue using the following steps:

```sh
$ git clone https://github.com/MrSam/docker-kreynet.git
$ cd docker-kreynet
$ docker build -t docker-kreynet .
```

### Running the server

To start a new container use the following command:

```sh
$ docker run -p 6667:6667 -ti docker-kreynet
```

You can now access the IRC server on localhost port 6667


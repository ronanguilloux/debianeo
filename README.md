# Debian 8, Apache and PHP 7 on Docker

__This image is not intended to be run AS IS but is rather to be used for building akeneo pim docker images__

It provides a pre-configured Apache (2.4) + mod_php (PHP 7.0) + MySQL web server, based on a single Debian 8 (Jessie) based container.
Apache is configured to run with the `docker` user.
The environment comes with some PHP 7.0 extensions: `acpu`, `mcrypt`, `intl`, `mysql`, `curl`, `gd`, `imagick`, `mongo` Mongo server non included.

This image is not intended to be use directly as it stands: You'd rather extend it and create custom environments on top of it.

Looking for Akeneo running on Docker? 
See [ronanguilloux/akeneo-pim-docker](https://github.com/ronanguilloux/akeneo-pim-docker) as an example, to run the last Akeneo PIM Community Edition in a Docker container with PHP7.

## How to use it?

### From Docker hub

You can directly pull this image from [Docker hub](https://hub.docker.com/r/ronanguilloux/debianeo/) by running:

### From GitHub

Clone the repository, go inside the created folder, and build the docker image:

```bash
    docker build -t "debianeo" .
```

## License

This repository is under the OSLv3 license. See the complete license in the `LICENSE` file.

# GNad

GNad's Not A Distro. Grabs a config file and setups your workstation for you. Only working with Ubuntu.

### Prerequisites

Run this before installing:
```sh
$ sudo apt update && sudo apt install curl -y
```
### Installing

Get the last version with:
```sh
$ wget https://github.com/cristianarbe/gnad/archive/master.zip
$ unzip master.zip
$ mv gnad-master /opt/gnad
$ ln -s /usr/local/bin /opt/gnad/gnad
```

## Usage

Run GNad with:
```sh
$ sudo gnad install [CONFIG FILE]
```

## Feedback

Suggestions/improvements
[welcome](https://github.com/cristianarbe/bootstrap-script/issues)!

## Authors

* **Cristian Ariza** - *Initial work* - [cristianarbe](https://github.com/cristianarbe)

## License

This project is licensed under the GPL-3.0 License - see the [LICENSE.md](LICENSE.md) file for details


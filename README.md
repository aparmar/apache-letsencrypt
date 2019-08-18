# apache-letsencrypt
simple docker container which has apache and letsencrypt

-------------------------
- [Requirements](#requirements)
- [Installation](#installation)
- [Preparation](#preparation)
- [Usage](#usage)
- [License](#license)

## Requirements
- Docker (tested with 19.03.1)
- Debian (your mileage may vary with other operating systems)

## Installation
Pull the image from the docker
```bash
sudo docker pull aparmar/apache-letsencrypt
```

## Preparation
Prepare a folder that will be the volume for this container It should have the following structure
- letsencrypt
- sites-available
- scripts
    - enable-mods.sh   
    - enable-sites.sh   
- log

enable-mods.sh referenced above will let you enable and disable modules. For example, you can put in things like

```bash
#!/bin/bash

# enable modules
a2enmod proxy
a2enmod proxy_html
a2enmod rewrite
a2enmod ssl
```

enable-sites.sh referenced above will let you enable and disable sites. For example, you can put in things like

```bash
#!/bin/bash

# enable sites
a2ensite app
a2ensite app-le-ssl
```

All the certs will get saved to letsencrypt, which can then be used in the next run of the container

## Usage
Run the container
```bash
FOLDER=~/apache
EMAIL=name@domain.com
DOMAIN=app.domain.com
sudo docker run -d --rm --name apache -e EMAIL=$EMAIL -e DOMAIN=$DOMAIN -v $FOLDER:/apache/data -p 80:80 -p 443:443 aparmar/apache-letsencrypt
```

For debugging, run the container in interactive mode
```bash
FOLDER=~/apache
EMAIL=name@domain.com
DOMAIN=app.domain.com
sudo docker run --rm -e EMAIL=$EMAIL -e DOMAIN=$DOMAIN -v $FOLDER:/apache/data -p 80:80 -p 443:443 -it aparmar/apache-letsencrypt /bin/bash
```

## License
This project is licensed under the [MIT License](LICENSE).

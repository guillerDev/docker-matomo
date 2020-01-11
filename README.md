## Start

Create a domain and point DNS register to IP server. Open 80 and 443 ports.

    git clone https://github.com/guillerDev/docker-matomo.git
    git submodule init
    git submodule update

Update db.env with keys.

    ./init-matomo.sh -d {DOMAIN_HERE} -e {YOUR_EMAIL}

### Docker-compose files:

 - *docker-compose.matomo.yml* matomo configuration
 - *docker-compose.override.yml* nginx+certbot configuration

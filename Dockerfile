FROM debian:buster
MAINTAINER Soul Assassino

#Install dependencies
RUN apt-get update && apt-get install -y wget ca-certificates gnupg --no-install-recommends

#Add repository
RUN wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg \
    && echo "deb http://download.proxmox.com/debian/pbs buster pbs-no-subscription" > /etc/apt/sources.list.d/pbs.list

#Install packages
RUN apt-get update \
    && apt-get install -y proxmox-backup-server \
    && rm -f /etc/apt/sources.list.d/pbs-enterprise.list

#Activate backup user
RUN chsh -s /bin/bash backup

#Start
VOLUME /datastore
EXPOSE 8007

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
STOPSIGNAL SIGINT
ENTRYPOINT ["/entrypoint.sh"]

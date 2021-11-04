# FROM debian:buster
# MAINTAINER Soul Assassino

# #Install dependencies
# RUN apt-get update && apt-get install -y wget ca-certificates gnupg --no-install-recommends

# #Add repository
# RUN wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg \
#     && echo "deb http://download.proxmox.com/debian/pbs buster pbs-no-subscription" > /etc/apt/sources.list.d/pbs.list

# #Install packages
# RUN apt-get update \
#     && apt-get install -y proxmox-backup-server \
#     && rm -f /etc/apt/sources.list.d/pbs-enterprise.list

# #Activate backup user
# RUN chsh -s /bin/bash backup

# #Start
# VOLUME /datastore
# EXPOSE 8007

# COPY entrypoint.sh /
# RUN chmod a+x /entrypoint.sh
# STOPSIGNAL SIGINT
# ENTRYPOINT ["/entrypoint.sh"]

FROM debian:bullseye-slim
MAINTAINER Soul Assassino

# Install dependencies
#ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates gnupg

# Add repository
RUN wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg \
#    && echo "deb http://ftp.debian.org/debian bullseye main contrib" > /etc/apt/sources.list \
#    && echo "deb http://ftp.debian.org/debian bullseye-updates main contrib" > /etc/apt/sources.list \
#    && echo "deb http://security.debian.org/debian-security bullseye-security main contrib" > /etc/apt/sources.list \
    && echo "deb http://download.proxmox.com/debian/pbs bullseye pbs-no-subscription" > /etc/apt/sources.list

# Install packages
RUN apt-get update \
    && apt-get install proxmox-backup-server -y \
    && rm -f /etc/apt/sources.list.d/pbs-enterprise.list

# Activate backup user
RUN chsh -s /bin/bash backup

# Start
VOLUME /datastore
EXPOSE 8007

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
STOPSIGNAL SIGINT
ENTRYPOINT ["/entrypoint.sh"]

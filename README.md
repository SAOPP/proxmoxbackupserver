# Proxmox Backup Server
Docker container of Proxmox Backup Server

# Stack
Example of the compose:
```
version: '2.1'
services:
  pbs:
    image: soulassassin85/pbs:latest
    container_name: proxmox-backup-server
    hostname: pbs
    environment:
     - TZ=Europe/Kiev
    ports:
      - 8007:8007
    volumes:
      - /etc/shadow:/etc/shadow:ro
      - /sharedfolders/Docker/pbs:/etc/proxmox-backup
      - /sharedfolders/Docker/pbs-storage:/datastore
    restart: unless-stopped
```

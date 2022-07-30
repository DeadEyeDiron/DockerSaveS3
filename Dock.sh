#!/bin/bash

echo "Lancement du script de sauvegarde Docker"

#Création des dossier suviant
mkdir /root/saveDocker/DOCKER1
mkdir /root/saveDocker/DOCKER2
mkdir /root/saveDocker/DOCKER3

#Sauvegarde de DOCKER 1
docker stop DOCKER1
tar -cvf /root/saveDocker/DOCKER1.tar  /Vers/Mon/Volume/Docker1
docker start DOCKER1

#Sauvegarde de DOCKER 1
docker stop DOCKER2
tar -cvf /root/saveDocker/DOCKER2.tar  /Vers/Mon/Volume/Docker2
docker start DOCKER2

#Sauvegarde de DOCKER 1
docker stop DOCKER3
tar -cvf /root/saveDocker/DOCKER3.tar  /Vers/Mon/Volume/Docker3
docker start DOCKER3

#Suppression des dossier
rm -r /root/saveDocker/DOCKER1
rm -r /root/saveDocker/DOCKER2
rm -r /root/saveDocker/DOCKER3

#Compression de sauvegarde
zip -r /root/SaveDocker.zip /root/saveDocker

#Modifier Le nom avec la date
ladate=`date +%Y_%m_%d`
chemin=/root/awstransfer
mv /root/SaveDocker.zip  $chemin/$ladate+Savedocker.zip

#Transfert vers S3
aws s3 mv awstransfer/$ladate+Savedocker.zip s3://VersMonbuketS3

#Suppression des Archive
rm -r /root/saveDocker/DOCKER1.tar 
rm -r /root/saveDocker/DOCKER2.tar 
rm -r /root/saveDocker/DOCKER3.tar 


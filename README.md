TP1 - Docker 
1. Installation de Docker et Docker-Compose fonctionnel
2. toutes les dommande de test docker fonction, le nginx est accéssible sur le port 80
3. *Ressource**

4. création du git et initialisation
    - création du repository via l'interface web
    - git init
    - git remote add origin https://github.com/TheGame43200/Ynov_TP1.git
    - git add .
    - git commit -m "First Git"


5. Début TP
    image choisi : 
        https://hub.docker.com/_/nginx

    commande déployement de nginx (volontairement rediriger vers le port 9090, mon port 80 étais déjà utiliser):
        docker pull nginx
        docker run --name Ynov-nginx -p 9090:80 -v /mnt/user/Docker-Ynov/tp\ 1/html:/usr/share/nginx/html -d nginx

    pour obtenir le meme résultat avec docker cp: 
        docker run --name Ynov-nginx -p 9090:80 -d nginx
        docker cp "/mnt/user/Docker-Ynov/tp 1/html/." Ynov-nginx:/usr/share/nginx/html/



6. Commande de build de docker : 
    docker build -t Ynov-nginx-image .
    docker images
    docker run --name mon-conteneur-build -d -p 9090:80 Ynov-nginx-image
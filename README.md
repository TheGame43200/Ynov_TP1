**TP1 - Docker** 
1. Installation de Docker et Docker-Compose fonctionnel
2. toutes les dommande de test docker fonction, le nginx est accéssible sur le port 80
3. **Ressource**

**4.création du git et initialisation**
    - création du repository via l'interface web
    - git init
    - git remote add origin https://github.com/TheGame43200/Ynov_TP1.git
    - git add .
    - git commit -m "First Git"


**5. Début TP**
    image choisi : 
        https://hub.docker.com/_/nginx

    commande déployement de nginx (volontairement rediriger vers le port 9090, mon port 80 étais déjà utiliser):
        docker pull nginx
        docker run --name Ynov-nginx -p 9090:80 -v /mnt/user/Docker-Ynov/tp\ 1/html:/usr/share/nginx/html -d nginx

    pour obtenir le meme résultat avec docker cp: 
        docker run --name Ynov-nginx -p 9090:80 -d nginx
        docker cp "/mnt/user/Docker-Ynov/tp 1/html/." Ynov-nginx:/usr/share/nginx/html/



**6. Builder une image**
    Commande de build de docker : 
        docker build -t Ynov-nginx-image .
        docker images
        docker run --name mon-conteneur-build -d -p 9090:80 Ynov-nginx-image
            Caractéristique	        Procédure 5 (Volume -v)	                            Procédure 6 (Dockerfile + build)
            Contenu de l'image	    Générique (ex: nginx, httpd)	                    Personnalisée, inclut l'application (HTML)
            Source des fichiers	    Système hôte	                                    Inclus dans l'image
            Modification code	    Immédiate (pas de rebuild)	                        Nécessite docker build + relance conteneur
            Portabilité	            Moins bonne (dépend des fichiers sur l'hôte)	    Excellente (image auto-suffisante)
            Cas d'usage idéal	    Développement local	                                Test, Staging, Production


**7. Utiliser une base de données dans un conteneur docker**    
    docker pull mysql:5.7
    docker pull phpmyadmin/phpmyadmin

    docker run -d --name=Ynov_mysql -e MYSQL_ROOT_PASSWORD=P@ssw0rd mysql:5.7
    docker run -d --name=Ynov_phpmyadmin --link Ynov_mysql:db -p 8080:80 phpmyadmin/phpmyadmin

    accés via le port 8080 
        user : root
        password : P@ssw0rd
**8. Utilisation de docker-compose.yml**
a. Création du fichier docker-compose.yml:
```bash
docker-compose up -d
```
b. Avantages de docker-compose:
- Configuration centralisée pour tous les services
- Gestion simplifiée du réseau et des volumes
- Orchestration complète en une seule commande
- Isolation réseau configurable entre services

**9. Observation de l'isolation réseau**
a. Vérification de l'isolation:
```bash
# Depuis le service web
docker exec -it tp1_web_1 ping db

# Depuis le service app
docker exec -it tp1_app_1 ping web

# Depuis le service db
docker exec -it tp1_db_1 ping web
```

b. Configuration réseau dans docker-compose.yml:
```yaml
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

c. Explication de l'isolation:
- Les services web et db ne partagent pas de réseau commun
- Le service app peut communiquer avec les deux réseaux
- La commande `docker inspect` montre les réseaux associés à chaque conteneur
- Cette configuration reflète un pattern web/app/db classique
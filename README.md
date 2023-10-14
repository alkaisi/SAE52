<div style="text-align: justify">
<div style="text-align: center">

# SAÉ52 - Piloter un projet informatique - Document explicatif

</div>

***Veuillez suivre les étapes étape par étapes, donc ne pas se tromper, si c'est le cas, veuillez supprimer les images et les conteneurs et les réinstaller*** 

## Introduction

Après avoir présenté les solutions existantes, nous verrons comment collecter les logs d'un serveur web Apache à l'aide d'Elasticsearch, Kibana et Filebeat. Pour cela, quatre scripts bash seront utilisés pour collecter les logs depuis l'interface graphique de Kibana (Elastic). Pour simplifier, j'ai renommé ces scripts :

- `FA_E02_Dockerfile_1.sh` ➡️ `setup1.sh`
- `FA_E02_Dockerfile_2.sh` ➡️ `setup2.sh`
- `FA_E02_Dockerfile_3.sh` ➡️ `setup3.sh`
- `FA_E02_Restart.sh` ➡️ `restart.sh`

## I. Installation d'Elasticsearch et Kibana

1. **Connexion à la machine virtuelle :**  
   Je me suis d'abord connecté comme utilisateur standard.  

2. **Passage en mode super utilisateur :**  
   J'ai accédé au Terminal et me suis connecté comme super utilisateur (root) en utilisant la commande `sudo -s`, suivi de mon mot de passe.  
   [![Login and terminal access](https://i.postimg.cc/nLvp3DZt/3.png)](https://postimg.cc/bGN7Jds6)

   Assurez-vous d'installer docker et docker-compose en utilisant la commande `apt install docker docker-compose`.

3. **Création du répertoire du projet :**  
   J'ai créé un répertoire `projet` pour y stocker mes scripts bash avec la commande `mkdir projet` et m'y suis déplacé avec `cd projet`.  
   [![Directory](https://i.postimg.cc/0j5SkvZb/4.png)](https://postimg.cc/ph7rCgwH)

4. **Autorisations du script :**  
   J'ai donné des droits d'exécution à `setup1.sh` en utilisant `chmod +x setup1.sh`.  
   [![Permission](https://i.postimg.cc/FHX93p5x/5.png)](https://postimg.cc/XpxS0wvZ)

5. **Exécution du script :**  
   J'ai lancé le premier script avec `./setup1.sh`. Ce script installe et lance Elasticsearch et Kibana comme des conteneurs Docker.
   [![Elasticsearch installation](https://i.postimg.cc/mZMd5y1q/6.png)](https://postimg.cc/jCxQWNXQ)
   [![Kibana installation](https://i.postimg.cc/hjCSWRYD/7.png)](https://postimg.cc/HcyGXRHR)

6. **Vérification des conteneurs :**  
   J'ai vérifié la liste des conteneurs exécutés avec `docker ps` et confirmé que Elasticsearch et Kibana étaient bien lancés. 
   [![Containers running](https://i.postimg.cc/FzMV9RCN/8.png)](https://postimg.cc/K35MfZyH)
    Les deux conteneurs elasticsearch et kibana sont bien exécutés, on peut le confirmer avec la statut « Up »

7. **Vérification des images Docker :**  
   Avec `docker images`, j'ai confirmé que les images Elasticsearch et Kibana étaient installées.  
   [![Docker images](https://i.postimg.cc/BQ8Jk6Gt/9.png)](https://postimg.cc/JGLwBR0W)

8. **Consultation des logs Kibana :**  
   J'ai utilisé `docker logs -f kibana` pour surveiller les logs de Kibana, essentiel pour déterminer quand accéder à l'interface graphique.  
   [![10.png](https://i.postimg.cc/vThXvM0s/10.png)](https://postimg.cc/dZ78sMMH)
   
Ne pas faire de `Ctrl + C`.

9. **Accès à l'interface de Kibana :**  
   Dans un navigateur de la machine virtuelle, j'ai accédé à Kibana via l'URL `localhost:5601`.  
   [![Kibana loading](https://i.postimg.cc/cJWgdYsF/11.png)](https://postimg.cc/yDfYPD3R) 

   Un message m'a informé que le service Kibana n'était pas encore prêt, donc je suis retourné au terminal. 
   
   [![Kibana starting](https://i.postimg.cc/05zBYJsW/12.png)](https://postimg.cc/nMt2ZrMB)
   
   Une fois Kibana lancé, j'ai rechargé la page.  
   [![Kibana interface](https://i.postimg.cc/DZvKff4V/13.png)](https://postimg.cc/FfB6D4xG)
   
   Dans le popup apparu, j'ai sélectionné "Explore on my own". L'interface graphique de Kibana était maintenant accessible.  
   [![Kibana's page](https://i.postimg.cc/L66BtcLH/14.png)](https://postimg.cc/6Tgvw1MS)

La suite consistera à suivre l'avancement des autres scripts tout en gardant l'interface graphique ouverte pour analyser les données.

## II. Installation de Filebeat

Filebeat permet de collecter les logs de plusieurs conteneurs. Pour installer et exécuter Filebeat, j'ai utilisé le deuxième script bash `setup2.sh`.

1. **Autorisations du script :**  
   J'ai attribué des droits d'exécution au script avec la commande `chmod +x setup2.sh`.  

2. **Exécution du script :**  
   En exécutant le script avec `./setup2.sh`, Filebeat a été installé et lancé. 
    [![Permission for setup2 & Script execution](https://i.postimg.cc/xT2jBQt2/15.png)](https://postimg.cc/NLdwrW3J)
   [![Filebeat execution](https://i.postimg.cc/LXKGh9q4/16.png)](https://postimg.cc/Mc59F8bg)

3. **Navigation dans l'interface Kibana :**  
   Le dernier message affiché m'indiquait que je devais recharger la page web de Kibana pour prendre en compte le service de collecte de logs Filebeat.  Je n’ai pas fait de `Ctrl + C` pour ne pas fermé la page puisqu’il faut bien recharger le page de Kibana avant l’exécution des autres scripts. Après le rechargement, je suis allé dans la rubrique "Management", accessible depuis le menu à gauche, en bas de la page.  
   [![Management](https://i.postimg.cc/vmdvVcvK/17.png)](https://postimg.cc/PC2ZGf9b)

4. **Accès à Index Management :**  
   J'ai ensuite cliqué sur "Index Management" de Elasticsearch, situé en haut à gauche de la page.  
   [![Management index](https://i.postimg.cc/BQHpQTTF/18.png)](https://postimg.cc/2Vjh0BXj)
   L'indice `filebeat` que j'avais installé était maintenant visible.

5. **Exploration des tableaux de bord :** 
   J'ai navigué dans le menu de gauche pour accéder aux tableaux de bord ("dashboards").  
   [![Dashboard](https://i.postimg.cc/NfdMXVkv/19.png)](https://postimg.cc/1fNshvdv)

   Le tableau de bord qui m'intéressait montrait les logs d'accès et d'erreur du serveur web Apache. Veuillez cliquer sur ce tableau de bord et charger la page, vous allez voir que il n'y a pas encore de donnée affichés (métriques et logs)
   [![Apache dashboard](https://i.postimg.cc/7LypZPJH/20.png)](https://postimg.cc/MndssSYN)

À noter que ces logs n'étaient pas encore disponibles car le serveur web Apache n'avait pas encore été installé et relié aux conteneurs Elasticsearch, Kibana, et Filebeat.

## III. Installation du serveur web Apache

Retour au terminal pour continuer les étapes d'installation.

1. **Arrêt du script précédent :**  
   Après avoir revu l'avancement du script précédent, j'ai terminé son exécution avec `Ctrl + C`.  
   [![Scripe 2 end](https://i.postimg.cc/LXKGh9q4/16.png)](https://postimg.cc/Mc59F8bg)

2. **Exécution du troisième script :**  
   Ce script comprend l'installation de la commande `curl` (utilisée pour télécharger le script de configuration de Filebeat), l'exécution d'un conteneur Filebeat avec une configuration avancée et l'installation et démarrage du serveur web Apache en association avec les conteneurs Elasticsearch, Kibana, et le nouveau Filebeat.  
   Après avoir donné les droits d'exécution avec `chmod +x setup3.sh`, j'ai lancé le script via `./setup3.sh`.  
   [![Script 3 execution](https://i.postimg.cc/hGDNmDcK/21.png)](https://postimg.cc/bZ56cjZ5)

3. **Vérification des images Docker :**  
   Avec la commande `docker images`, j'ai confirmé l'installation des 4 images : Elastic, Kibana, Filebeat, et httpd.  
   [![Docker images verification](https://i.postimg.cc/x14LvgSq/22.png)](https://postimg.cc/SncXq6Rp)

4. **Vérification des conteneurs Docker :**  
   La commande `docker ps` m'a permis de vérifier que les 4 conteneurs étaient bien en cours d'exécution. Ces conteneurs sont : `elasticsearch`, `kibana`, `filebeat`, et `my-apache-app`.  
   [![Docker containers verification](https://i.postimg.cc/B6qZX9wF/23.png)](https://postimg.cc/3ycQc6hr)

Tous les éléments sont correctement installés et fonctionnent comme attendu.

## IV. Visualiser les logs de serveur web Apache

Après avoir correctement configuré et redémarré tous les conteneurs, je suis en mesure de visualiser les logs du serveur web Apache directement depuis l'interface de Kibana.

1. **Accès à l'interface de Kibana :**  
   J'ai ouvert un navigateur et accédé à Kibana en utilisant l'URL `localhost:5601` (déjà ouvert dans mon cas).
   
2. **Navigation vers le tableau de bord approprié :**  
   J'ai ensuite cliqué sur la rubrique "Dashboard" (Tableau de bord). De là, j'ai sélectionné le tableau de bord intitulé "[Filebeat Apache] Access and error Logs ECS".  
   [![Kibana dashboard selection](https://i.postimg.cc/bN2K1VnF/26.png)](https://postimg.cc/jLtgbXZz) 
   [![Filebeat Apache dashboard](https://i.postimg.cc/vmdgGK7R/27.png)](https://postimg.cc/VJDLRDH4)

3. **Examen des logs et des métriques :**  
   Ce tableau de bord m'a fourni un aperçu visuel des statistiques du serveur Apache, notamment sous forme de graphiques et de métriques. En descendant un peu plus bas, j'ai également pu voir les logs d'accès et d'erreurs du serveur.  
   [![Apache statistics](https://i.postimg.cc/903FBRL6/28.png)](https://postimg.cc/9RphmM5b)
   [![Apache logs](https://i.postimg.cc/9frm5tK3/29.png)](https://postimg.cc/XZ6S9Fnx)

Ces outils de visualisation offerts par Kibana rendent l'analyse des logs et la surveillance de l'activité du serveur Apache beaucoup plus simples et plus efficaces.

## V. Redémarrage des conteneurs (Optionnel)

Pour faciliter la gestion des conteneurs après leur installation initiale, j'ai créé un script `restart.sh`. Contrairement aux scripts précédents (setup1.sh, setup2.sh, setup3.sh), celui-ci est conçu pour être utilisé plusieurs fois, notamment après que les images et les conteneurs ont été installés.

1. **Démarrage de la machine virtuelle :**  
   Après avoir redémarré la machine virtuelle, je me suis connecté en tant qu'utilisateur puis j'ai lancé la commande `docker ps` pour vérifier l'état des conteneurs.  
   [![Containers ckeck](https://i.postimg.cc/nV358b4W/24.png)](https://postimg.cc/kDtw8HhN)

2. **Exécution du script `restart.sh` :**  
   J'ai navigué vers le dossier `projet`, donné les droits d'exécution au script avec `chmod +x restart.sh` et enfin lancé le script avec `./restart.sh`.  

3. **Vérification des conteneurs :**  
   Après avoir exécuté le script, j'ai vérifié à nouveau l'état des conteneurs. Les conteneurs `elasticsearch`, `kibana`, `filebeat` et `my-apache-app` étaient tous en cours d'exécution.  
   [![Containers running verification](https://i.postimg.cc/X7pnmgCw/25.png)](https://postimg.cc/ykCqScnd)

Cela confirme que le script `restart.sh` fonctionne comme prévu, redémarrant tous les conteneurs nécessaires.

 **Assurz-vous que Kibana est lancé en consultant la commande `docker logs -f kibana` comme vu précédement, voir la première partie de document explicatif.**

## Conclusion
Au travers de cette démonstration, nous avons illustré comment Elastic Stack, combiné avec Docker, peut transformer de simples logs de serveur en visualisations informatives et exploitables. Cette intégration facilite la surveillance, la détection d'anomalies et la prise de décision, soulignant l'efficacité et l'importance de la centralisation des logs dans le monde moderne de l'informatique.

</div>

# Synchronisation Obsidian avec CouchDB

Ce projet utilise **Docker** et **CouchDB** pour déployer une solution de synchronisation pour Obsidian sur une plateforme VPS ou toute autre plateforme compatible avec Docker. Il s'appuie sur la repository de **DNSWD** et a été conçu pour héberger un service de synchronisation auto-hébergé pour Obsidian.

## Étapes de Mise en Place

### 1. Cloner le dépôt
Commence par cloner ce dépôt sur ta machine ou serveur.

```bash
git clone https://github.com/zamk-paw/couchdb-obsidian.git
cd couchdb-obsidian
```

### 2. Créer un fichier `.env`
Pour simplifier la gestion des variables sensibles comme le nom d'utilisateur et le mot de passe, crée un fichier `.env` à la racine du projet. Ce fichier contiendra les variables d'environnement utilisées pour la configuration.

Exemple de contenu du fichier `.env` :

```
DB_USERNAME=ton_utilisateur
DB_PASSWORD=ton_mot_de_passe
```

### 3. Lancer le service avec Docker Compose
Ensuite, exécute la commande suivante pour déployer CouchDB à l'aide de Docker Compose. Docker Compose utilisera automatiquement les variables définies dans le fichier `.env`.

```bash
docker compose up
```

### 4. Vérifier le bon fonctionnement de CouchDB
Accède à l'URL suivante pour vérifier que CouchDB fonctionne correctement :

```
http://ip_de_ta_machine:5984
```

Tu devrais voir une page qui confirme que CouchDB est opérationnel.

### 5. Configuration via le Tableau de Bord Fauxton
Navigue vers le tableau de bord Fauxton pour configurer CouchDB en mode mono-nœud. Fauxton est l'interface d'administration graphique de CouchDB.

```
http://ip_de_ta_machine:5984/_utils/#/setup
```

Suis les instructions pour configurer CouchDB en tant que nœud unique.

### 6. Vérification de l'Installation
Vérifie que l'installation est complète et correcte en visitant cette URL :

```
http://ip_de_ta_machine:5984/_utils/#/verifyinstall
```

---

## Synchronisation Obsidian avec Obsidian LiveSync

**Obsidian LiveSync** est un plugin qui te permet de synchroniser ton coffre Obsidian avec une base de données distante, comme celle que tu viens de configurer avec CouchDB.

### Étapes d'installation et de configuration

#### 1. Installer le Plugin `Self-hosted LiveSync`
Dans Obsidian, installe le plugin **Self-hosted LiveSync** depuis la section des plugins communautaires.

#### 2. Configurer la Base de Données Distante
Accède aux paramètres du plugin et renseigne les informations suivantes dans la section **Remote Database Configuration** :

- **IP de la machine** : `ip_de_ta_machine`
- **Port** : `5984`
- **Nom d'utilisateur** : `ton_utilisateur` (défini dans le fichier `.env`)
- **Mot de passe** : `ton_mot_de_passe` (défini dans le fichier `.env`)

#### 3. Créer une Nouvelle Base de Données dans Fauxton
Dans le tableau de bord Fauxton, crée une nouvelle base de données appelée `obsidian-livesync`.

#### 4. Configurer le Plugin dans Obsidian
Dans les paramètres du plugin, entre le nom de la base de données (`obsidian-livesync`) dans la section appropriée. Ensuite, clique sur le bouton **Test Database Connection** pour vérifier que la connexion à la base de données fonctionne correctement.


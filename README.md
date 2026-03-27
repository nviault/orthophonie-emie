# DysVoix / L'Odyssée de l'Île d'Émie

| Champ | Valeur |
|---|---|
| **Nom** | DysVoix / L'Odyssée de l'Île d'Émie |
| **Description** | Application thérapeutique Flutter Android d'aide à l'élocution pour enfants atteints de dyspraxie verbale |
| **Cible** | Android — Pixel 8 Pro, Xiaomi Redmi Pad Pro — `minSdk 24` |
| **Architecture** | BLoC + GetIt, stockage local Hive chiffré AES-256 |
| **Contrainte médicale clé** | Sessions limitées à **10 minutes maximum** |
| **Statut** | MVP en développement actif |

---

# Guide d'Installation sur Ubuntu 24.04

Ce guide est destiné aux débutants souhaitant configurer leur environnement de développement pour l'application **orthophonie_emie** (DysVoix) sur Ubuntu 24.04.

---

## 1. Mise à jour du système

Avant de commencer, assurez-vous que votre système est à jour. Ouvrez un terminal et exécutez les commandes suivantes :

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 2. Installation de Flutter

Nous allons utiliser `snap` pour installer Flutter, car c'est la méthode la plus simple sur Ubuntu.

1. Dans votre terminal, lancez :
   ```bash
   sudo snap install flutter --classic
   ```
2. Initialisez Flutter (cela peut prendre un moment) :
   ```bash
   flutter sdk-path
   ```

---

## 3. Configuration d'Android Studio

Android Studio est nécessaire pour compiler l'application et gérer les simulateurs.

### Installation via Snap
Dans votre terminal, exécutez :
```bash
sudo snap install android-studio --classic
```

### Configuration initiale
1. Lancez **Android Studio** depuis votre menu d'applications.
2. Suivez l'assistant d'installation (**Standard** est recommandé).
3. Une fois l'installation terminée, sur l'écran d'accueil, cliquez sur **More Actions** > **SDK Manager** (ou allez dans **Settings** > **Languages & Frameworks** > **Android SDK**).
4. Allez dans l'onglet **SDK Tools**.
5. Cochez la case **Android SDK Command-line Tools (latest)**.
6. Cliquez sur **Apply** pour installer.

### Acceptation des licences
Retournez dans votre terminal et exécutez la commande suivante pour accepter toutes les licences Android :
```bash
flutter doctor --android-licenses
```
Appuyez sur `y` (pour "yes") à chaque demande.

---

## 4. Configuration de l'émulateur Android (AVD)

Pour tester l'application sur votre ordinateur :
1. Dans Android Studio, sur l'écran d'accueil, cliquez sur **More Actions** > **Virtual Device Manager**.
2. Cliquez sur **Create Device**.
3. Choisissez un modèle (ex: Pixel 7) et cliquez sur **Next**.
4. Sélectionnez une image système récente (ex: API 34) et téléchargez-la en cliquant sur la flèche à côté du nom.
5. Une fois téléchargée, sélectionnez-la et cliquez sur **Next** puis **Finish**.
6. Lancez l'émulateur en cliquant sur l'icône "Play" (triangle vert).

---

## 5. Configuration de VS Code

VS Code est l'éditeur recommandé pour coder en Flutter.

1. Installez VS Code :
   ```bash
   sudo snap install code --classic
   ```
2. Ouvrez VS Code.
3. Cliquez sur l'icône **Extensions** dans la barre latérale gauche (ou faites `Ctrl+Shift+X`).
4. Recherchez "Flutter" et cliquez sur **Install**. (Cela installera aussi l'extension "Dart").

---

## 6. Vérification finale

Lancez cette commande pour vérifier que tout est prêt :
```bash
flutter doctor
```
Si vous voyez des coches vertes partout (ignorez la partie "Chrome" ou "Linux Desktop" si vous ne développez que pour Android), votre environnement est prêt !

---

## 7. Lancement du projet orthophonie_emie

Maintenant, préparez et lancez l'application :

1. **Ouvrir le projet :**
   Ouvrez VS Code, faites `File > Open Folder...` et sélectionnez le dossier du projet `orthophonie_emie`.

2. **Récupérer les dépendances :**
   Ouvrez le terminal intégré dans VS Code (`Ctrl+ù` ou `Terminal > New Terminal`) et tapez :
   ```bash
   flutter pub get
   ```

3. **Lancer l'application :**
   Assurez-vous que votre émulateur est allumé, puis tapez dans le terminal :
   ```bash
   flutter run
   ```

---

## Dépannage
- **Erreur de KVM :** Si l'émulateur ne se lance pas, vous devrez peut-être activer la virtualisation dans votre BIOS ou installer KVM (`sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils`).
- **Flutter non trouvé :** Si la commande `flutter` n'est pas reconnue, redémarrez votre terminal ou votre session.

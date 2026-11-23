# Voyage ✈️

Application mobile **Flutter** de voyage, développée dans le cadre de l'atelier cross-platform (3ème DSI).

## Fonctionnalités

- Authentification et inscription (Firebase Authentication)
- Mode Jour / Nuit synchronisé avec Firebase Realtime Database
- Météo
- Galerie
- Pays
- Contact
- Traduction (Google ML Kit)
- Synthèse vocale (flutter_tts)
- Paramètres

## Technologies

- Flutter 3.50.1 / Dart 3.14
- Firebase Core, Auth, Realtime Database
- Google ML Kit (Language ID, Translation)
- flutter_tts

## Prérequis

- Flutter SDK 3.50.1 ou plus récent
- Android Studio avec Android SDK et NDK 28.2.13676358
- Un compte Firebase

## Installation

1. Cloner le projet :

   ```bash
   git clone https://github.com/AmenAllah-Jayari/voyage.git
   cd voyage
   ```

2. Installer les dépendances :

   ```bash
   flutter pub get
   ```

3. Configurer Firebase (les fichiers de configuration ne sont pas publiés) :

   - Créer un projet sur la [Firebase Console](https://console.firebase.google.com)
   - Ajouter une application Android avec le package `com.example.voyage`
   - Télécharger `google-services.json` et le placer dans `android/app/`
   - Générer `lib/firebase_options.dart` avec FlutterFire CLI :

     ```bash
     dart pub global activate flutterfire_cli
     flutterfire configure
     ```

   - Activer **Authentication** (Email/Password) et **Realtime Database**

4. Lancer l'application :

   ```bash
   flutter run
   ```

## Structure du projet

```
lib/
├── config/                 # Paramètres globaux et thème
├── pages/                  # Pages de l'application
├── main.dart               # Point d'entrée
└── firebase_options.dart   # (non publié)
```

## Auteur

**Amen Allah Jayari** - 3ème DSI

GitHub : [AmenAllah-Jayari](https://github.com/AmenAllah-Jayari)

import 'package:flutter/material.dart';
import '../notifier/theme.dart';

class GlobalParams {
  static List<Map<String, dynamic>> accueil = [
    {"title": "Météo", "image": "images/meteo.png", "route": "/meteo"},
    {"title": "Gallerie", "image": "images/gallerie.png", "route": "/gallerie"},
    {"title": "Pays", "image": "images/pays.png", "route": "/pays"},
    {"title": "Contact", "image": "images/contact.png", "route": "/contact"},
    {"title": "Traduction", "image": "images/traduction.png", "route": "/traduction"}, // JDID
    {"title": "Paramètres", "image": "images/parametres.png", "route": "/parametres"},
    {"title": "Déconnexion", "image": "images/deconnexion.png", "route": "/authentification"},
  ];
  static List<Map<String, dynamic>> menus = [
    {
      "title": "Accueil",
      "icon": Icon(Icons.home, color: Colors.blue),
      "route": "/home"
    },
    {
      "title": "Météo",
      "icon": Icon(Icons.sunny_snowing, color: Colors.blue),
      "route": "/meteo"
    },
    {
      "title": "Gallerie",
      "icon": Icon(Icons.photo, color: Colors.blue),
      "route": "/gallerie"
    },
    {
      "title": "Pays",
      "icon": Icon(Icons.location_city, color: Colors.blue),
      "route": "/pays"
    },
    {
      "title": "Contact",
      "icon": Icon(Icons.contact_page, color: Colors.blue),
      "route": "/contact"
    },
    // JDID
    {
      "title": "Traduction",
      "icon": Icon(Icons.translate, color: Colors.blue),
      "route": "/traduction"
    },
    {
      "title": "Paramètres",
      "icon": Icon(Icons.settings, color: Colors.blue),
      "route": "/parametres"
    },
    {
      "title": "Déconnexion",
      "icon": Icon(Icons.logout, color: Colors.blue),
      "route": "/authentification"
    },
  ];
  static MonTheme themeActuel = MonTheme();
}
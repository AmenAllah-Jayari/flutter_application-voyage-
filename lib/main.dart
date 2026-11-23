import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'config/global.params.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'pages/meteo.page.dart';
import 'pages/gallerie.page.dart';
import 'pages/pays.page.dart';
import 'pages/contact.page.dart';
import 'pages/parametres.page.dart';
import 'pages/traduction.page.dart'; // JDID

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') rethrow;
    // Firebase déjà initialisé par google-services, on continue
  }

  GlobalParams.themeActuel.setMode(await _onGetMode());
  runApp(const MyApp());
}

Future<String> _onGetMode() async {
  try {
    final snapshot = await FirebaseDatabase.instance
        .ref()
        .child('mode')
        .get()
        .timeout(const Duration(seconds: 5));
    if (snapshot.exists) {
      return snapshot.value.toString();
    }
  } catch (_) {
    // ken fama mochkla réseau walla règles, nrajj3ou "Jour"
  }
  return "Jour";
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final Map<String, WidgetBuilder> routes = {
    '/home': (context) => const HomePage(),
    '/inscription': (context) => const InscriptionPage(),
    '/authentification': (context) => const AuthentificationPage(),
    '/meteo': (context) => const MeteoPage(),
    '/gallerie': (context) => const GalleriePage(),
    '/pays': (context) => const PaysPage(),
    '/contact': (context) => const ContactPage(),
    '/parametres': (context) => const ParametresPage(),
    '/traduction': (context) => const TraductionPage(), // JDID
  };

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalParams.themeActuel.getTheme(),
      routes: MyApp.routes,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const AuthentificationPage();
          }
        },
      ),
    );
  }
}
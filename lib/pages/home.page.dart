import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config/global.params.dart';
import '../menu/drawer.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = FirebaseAuth.instance.currentUser?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Home'),
        backgroundColor: Colors.blue,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Utilisateur: $email',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    ...(GlobalParams.accueil as List).map((item) {
                      return InkWell(
                        child: Ink.image(
                          height: 180,
                          width: 180,
                          image: AssetImage('${item['image']}'),
                        ),
                        onTap: () async {
                          if ('${item['title']}' != "Déconnexion") {
                            Navigator.pushNamed(context, "${item['route']}");
                          } else {
                            await _deconnexion(context);
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deconnexion(BuildContext context) async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    navigator.pushNamedAndRemoveUntil('/authentification', (route) => false);
  }
}
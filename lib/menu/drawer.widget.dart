import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white, Colors.blue]),
            ),
            child: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/profile.png"),
                radius: 80,
              ),
            ),
          ),
          ...(GlobalParams.menus as List).map((item) {
            return Column(
              children: [
                ListTile(
                  title: Text('${item['title']}',
                      style: const TextStyle(fontSize: 22)),
                  leading: item['icon'],
                  trailing: const Icon(Icons.arrow_right, color: Colors.blue),
                  onTap: () async {
                    if ('${item['title']}' != "Déconnexion") {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "${item['route']}");
                    } else {
                      final navigator = Navigator.of(context);
                      await FirebaseAuth.instance.signOut();
                      navigator.pushNamedAndRemoveUntil(
                          '/authentification', (route) => false);
                    }
                  },
                ),
                const Divider(height: 4, color: Colors.blue),
              ],
            );
          }),
        ],
      ),
    );
  }
}
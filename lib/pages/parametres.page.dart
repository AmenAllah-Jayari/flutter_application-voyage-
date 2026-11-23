import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../config/global.params.dart';
import '../menu/drawer.widget.dart';
import '../notifier/theme.dart';

class ParametresPage extends StatefulWidget {
  const ParametresPage({Key? key}) : super(key: key);

  @override
  State<ParametresPage> createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  String mode = MonTheme.mode; // el mode el 7ali
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(title: const Text("Page Paramètres")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Center(
            child: Text('Mode', style: TextStyle(fontSize: 22)),
          ),
          ListTile(
            title: const Text('Jour'),
            leading: Radio<String>(
              value: "Jour",
              groupValue: mode,
              onChanged: (value) {
                setState(() {
                  mode = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Nuit'),
            leading: Radio<String>(
              value: "Nuit",
              groupValue: mode,
              onChanged: (value) {
                setState(() {
                  mode = value!;
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: _onSaveMode,
              child: const Text('Enregistrer', style: TextStyle(fontSize: 22)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSaveMode() async {
    await ref.set({"mode": mode});
    GlobalParams.themeActuel.setMode(mode);
    if (!mounted) return;
    Navigator.pop(context);
  }
}
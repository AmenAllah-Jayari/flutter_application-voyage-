import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';

class PaysPage extends StatelessWidget {
  const PaysPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: const Text("Page pays")),
      body: const Center(
        child: Text("Page pays", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
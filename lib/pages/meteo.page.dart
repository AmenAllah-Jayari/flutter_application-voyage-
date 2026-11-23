import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'meteo-details.page.dart';

class MeteoPage extends StatefulWidget {
  const MeteoPage({Key? key}) : super(key: key);

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  TextEditingController txt_ville = TextEditingController();

  @override
  void dispose() {
    txt_ville.dispose();
    super.dispose();
  }

  void _onGetMeteoDetails(BuildContext context) {
    String v = txt_ville.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MeteoDetailsPage(v)),
    );
    txt_ville.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: const Text("Page Météo")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txt_ville,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_city),
                hintText: 'Ville',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _onGetMeteoDetails(context),
                child: const Text('Chercher', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
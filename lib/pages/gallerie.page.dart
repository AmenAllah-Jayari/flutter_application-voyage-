import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'gallerie-details.page.dart';

// Étapes 1 et 3 : formulaire (zone de texte + bouton) et navigation
class GalleriePage extends StatefulWidget {
  const GalleriePage({Key? key}) : super(key: key);

  @override
  State<GalleriePage> createState() => _GalleriePageState();
}

class _GalleriePageState extends State<GalleriePage> {
  final TextEditingController _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  // Bascule vers GallerieDetailsPage en lui passant la clé saisie
  void _onGetGallerieDetails(BuildContext context) {
    final String keyword = _keywordController.text.trim();
    if (keyword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez saisir un mot-clé')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GallerieDetailsPage(keyword)),
    );
    _keywordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: const Text('Page Gallerie')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _keywordController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _onGetGallerieDetails(context),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.photo_library),
                hintText: 'Keyword',
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
                onPressed: () => _onGetGallerieDetails(context),
                child: const Text('Chercher', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
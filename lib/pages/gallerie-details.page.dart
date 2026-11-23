import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String pixabayKey = '58121583-70a6eac09e5333f4c30709256';


class GallerieDetailsPage extends StatefulWidget {
  final String keyword;
  const GallerieDetailsPage(this.keyword, {super.key});

  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size = 10;
  int totalPages = 0;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];
  var galleryData;

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages && !isLoading) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }


  void getGalleryData(String keyword) {
    isLoading = true;
    final uri = Uri.https('pixabay.com', '/api/', {
      'key': pixabayKey,
      'q': keyword,
      'page': '$currentPage',
      'per_page': '$size',
    });
    http.get(uri).then((resp) {
      final data = json.decode(resp.body);
      if (!mounted) return;
      setState(() {
        galleryData = data;
        hits.addAll(data['hits'] ?? []);
        totalPages = ((data['totalHits'] ?? 0) / size).ceil();
        isLoading = false;
      });
      print(hits);
    }).catchError((err) {
      print(err);
      if (!mounted) return;
      setState(() {
        galleryData ??= {'hits': [], 'totalHits': 0};
        if (currentPage > 1) currentPage--;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: galleryData == null
            ? Text(widget.keyword)
            : totalPages == 0
            ? const Text('Pas de résultats')
            : Text("${widget.keyword}, Page $currentPage/$totalPages"),
      ),
      body: (galleryData == null)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        itemCount: hits.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      hits[index]['tags'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  child: Image.network(
                    hits[index]['webformatURL'],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
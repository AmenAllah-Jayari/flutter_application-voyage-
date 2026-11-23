import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String ville;
  const MeteoDetailsPage(this.ville, {super.key});

  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  void getMeteoData(String ville) {
    print("Météo de la ville de $ville");
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$ville&appid=038e172793d3ff14fb724c3e54d1c2cf";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        meteoData = json.decode(resp.body);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Meteo Details ${widget.ville}')),
      body: meteoData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: meteoData['list'].length,
        itemBuilder: (context, index) {
          final item = meteoData['list'][index];
          final date =
          DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
          final etatApi = item['weather'][0]['main'].toString();
          final temp = (item['main']['temp'] - 273.15).round();

          const connus = [
            'clear', 'clouds', 'rain', 'snow',
            'mist', 'thunderstorm', 'drizzle'
          ];
          final etat = etatApi.toLowerCase();
          final image = connus.contains(etat) ? etat : 'clear';

          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Color(0xFFEEEEEE)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.4, 1.0],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CircleAvatar(
                          backgroundImage:
                          AssetImage("images/$image.png"),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('E-dd/MM/yyyy').format(date),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${DateFormat('HH:mm').format(date)} | $etatApi",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "$temp °C",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:flutter_tts/flutter_tts.dart'; // JDID

class TraductionPage extends StatefulWidget {
  const TraductionPage({super.key});

  @override
  State<TraductionPage> createState() => _TraductionPageState();
}

class _TraductionPageState extends State<TraductionPage> {
  final _controller = TextEditingController();
  final _modelManager = OnDeviceTranslatorModelManager();
  final FlutterTts _tts = FlutterTts(); // JDID

  TranslateLanguage _source = TranslateLanguage.french;
  TranslateLanguage _target = TranslateLanguage.english;
  String _result = '';
  bool _loading = false;

  Future<void> _translate() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _loading = true);

    try {
      // Tnazzel el modèles ken ma7oumch mawjoudin (awel mara bark, yehtej internet)
      for (final lang in [_source, _target]) {
        final downloaded = await _modelManager.isModelDownloaded(lang.bcpCode);
        if (!downloaded) await _modelManager.downloadModel(lang.bcpCode);
      }

      final translator = OnDeviceTranslator(
        sourceLanguage: _source,
        targetLanguage: _target,
      );
      final text = await translator.translateText(_controller.text);
      await translator.close();

      setState(() => _result = text);
    } catch (e) {
      setState(() => _result = 'Erreur: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  // JDID
  Future<void> _speak(String text, TranslateLanguage lang) async {
    if (text.trim().isEmpty) return;
    await _tts.setLanguage(lang.bcpCode); // zay "en", "fr", "ar"
    await _tts.setSpeechRate(0.5);
    await _tts.speak(text);
  }

  void _swap() {
    setState(() {
      final tmp = _source;
      _source = _target;
      _target = tmp;
      _result = '';
    });
  }

  Widget _langDropdown(TranslateLanguage value, ValueChanged<TranslateLanguage?> onChanged) {
    return DropdownButton<TranslateLanguage>(
      value: value,
      items: TranslateLanguage.values
          .map((l) => DropdownMenuItem(value: l, child: Text(l.name)))
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _tts.stop(); // JDID
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Traduction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _langDropdown(_source, (l) => setState(() => _source = l!)),
                IconButton(icon: const Icon(Icons.swap_horiz), onPressed: _swap),
                _langDropdown(_target, (l) => setState(() => _target = l!)),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ecrire le texte...',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _translate,
              child: _loading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Traduire'),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: SelectableText(_result.isEmpty ? 'voici la traduction' : _result),
            ),
            // JDID: zorr écouter
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.volume_up, color: Colors.blue),
                tooltip: 'Écouter',
                onPressed: () => _speak(_result, _target),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
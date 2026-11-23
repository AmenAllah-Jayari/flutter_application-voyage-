import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';
import 'ajout_modif_contact.page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactService contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Contact'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: FormHelper.submitButton(
                "Ajout",
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AjoutModifContactPage(),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                borderRadius: 10,
                btnColor: Colors.blue,
                borderColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            _fetchData(),
          ],
        ),
      ),
    );
  }

  _fetchData() {
    return FutureBuilder<List<Contact>>(
      future: contactService.listeContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts) {
        if (contacts.hasData) return _buildDataTable(contacts.data!);
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildDataTable(List<Contact> listContacts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListUtils.buildDataTable(
        context,
        ["Nom", "Telephone", "Action"],
        ["nom", "tel", ""],
        false,
        0,
        listContacts,
            (Contact c) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjoutModifContactPage(
                modifMode: true,
                contact: c,
              ),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        // ---------- Supprimer contact ----------
            (Contact c) {
          return showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text("Supprimer Contact"),
                content: const Text(
                    "Etes vous sur de vouloir supprimer ce contact?"),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormHelper.submitButton(
                        "Oui",
                            () async {
                          await contactService.supprimerContact(c);
                          if (!mounted) return;
                          setState(() {});
                          Navigator.of(dialogContext).pop();
                        },
                        width: 100,
                        borderRadius: 5,
                        btnColor: Colors.green,
                        borderColor: Colors.green,
                      ),
                      const SizedBox(width: 20),
                      FormHelper.submitButton(
                        "Non",
                            () {
                          Navigator.of(dialogContext).pop();
                        },
                        width: 100,
                        borderRadius: 5,
                      ),
                    ],
                  )
                ],
              );
            },
          );
        },
        headingRowColor: Colors.orangeAccent,
        isScrollable: true,
        columnTextFontSize: 20,
        columnTextBold: false,
        columnSpacing: 50,
        onSort: (columnIndex, columnName, asc) {},
      ),
    );
  }
}
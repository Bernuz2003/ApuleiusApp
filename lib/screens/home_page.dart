import "package:flutter/material.dart";
import 'package:tutorial/screens/preparazioni_page.dart';
import "../helper/db_helper.dart";
import "../model/spesa.dart";
import 'spesa_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _FirstPageState();
}

class _FirstPageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Aggiungi elemento nel database',),
        onPressed: (){aggiungiElemento(context);})
      );
  }

  Widget buildBody() {
    return Center(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 250,
              child: 
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SpesaPage();
                        },
                      ),
                    );
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                  child: Text('Spesa', style: TextStyle(fontSize: 30,))
                ),
            ),
            SizedBox(
              height: 150,),
            SizedBox(
              height: 100,
              width: 250,
              child:
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return PreparazioniPage();
                          },
                        ),
                    );
                  },
                  style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                  child: Text('Preparazioni', style: TextStyle(fontSize: 30,))
                ),
            ),
            SizedBox(height: 120,)
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
  return AppBar(
            backgroundColor: Colors.blueGrey,
            elevation: 20,
            shadowColor: Colors.black,
            centerTitle: true,
            bottomOpacity: 0.8,
            toolbarHeight: 70,
            title: Text(
              'Apuleius',
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            )
        );
  }

  late TextEditingController articoloController;
  late TextEditingController fornitoreController;
  late TextEditingController tiestampController;
  late TextEditingController termineController;
  late TextEditingController n_listaController;

  @override
  void initState() {
    super.initState();
    articoloController = TextEditingController();
    fornitoreController = TextEditingController();
    tiestampController = TextEditingController();
    termineController = TextEditingController();
    n_listaController = TextEditingController();
  }

  void aggiungiElemento(BuildContext context) {
    // Recupera l'altezza dello schermo
    //double screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aggiungi Elemento'),
          content: IntrinsicHeight(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: articoloController,
                    decoration: InputDecoration(labelText: 'Articolo'),
                  ),
                  TextField(
                    controller: fornitoreController,
                    decoration: InputDecoration(labelText: 'Fornitore'),
                  ),
                  TextField(
                    controller: tiestampController,
                    decoration: InputDecoration(labelText: 'Timestamp'),
                  ),
                  TextField(
                    controller: termineController,
                    decoration: InputDecoration(labelText: 'Termine'),
                  ),
                  TextField(
                    controller: n_listaController,
                    decoration: InputDecoration(labelText: 'Numero Lista'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () {
                aggiungiElementoAlDatabase();
                Navigator.of(context).pop();
              },
              child: Text('Aggiungi'),
            ),
          ],
        );
      },
    );
  }

  void aggiungiElementoAlDatabase() async {
    Spesa nuovoElemento = Spesa(
      id: null, // Lascia che il database assegni un ID automaticamente
      articolo: articoloController.text,
      fornitore: fornitoreController.text,
      timestamp: tiestampController.text,
      termine: termineController.text,
      n_lista: n_listaController.text,
    );

    await DatabaseHelper.instance.aggiungi(nuovoElemento);
  }
}


import 'package:flutter/material.dart';
import '../helper/db_helper.dart';
import '../helper/dialog_helper.dart';
import '../helper/list_builder.dart';
import '../model/spesa.dart';

class CustomPage extends StatefulWidget {
  final String title;
  final Future<List<Spesa>> Function(String) getDataFunction;

  CustomPage({Key? key, required this.title, required this.getDataFunction}) : super(key: key);

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  late Future<List<Spesa>> dati;

  @override
  void initState() {
    super.initState();
    dati = widget.getDataFunction('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
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
        widget.title,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber),
      ),
      actions: [
        IconButton(iconSize: 30, onPressed: () {}, icon: Icon(Icons.filter_list_rounded)),
        IconButton(
          iconSize: 30,
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
          icon: Icon(Icons.search),
        )
      ],
      bottom: isSearching ? mostraRicercaField() : null,
    );
  }

  PreferredSizeWidget mostraRicercaField() {
    return PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Cerca',
            border: OutlineInputBorder(),
          ),
          onTapOutside: (event) {
            setState(() {
              isSearching = false;
            });
          },
          onChanged: (query) {
            setState(() {
              dati = DatabaseHelper.instance.getElementoByNome(searchController.text);
            });
          },
        ),
      ),
    );
  }

  Widget buildBody() {
    return Center(
      child: FutureBuilder<List<Spesa>>(
        future: dati,
        builder: (BuildContext context, AsyncSnapshot<List<Spesa>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading...'));
          }

          return snapshot.data!.isEmpty
              ? Center(child: Text('Non ci sono elementi nel database.'))
              : ListBuilder.build_list(snapshot.data!, onTap, onLongPress);
        },
      ),
    );
  }

  void onTap(Spesa spesa) {
    DialogHelper.mostra_info_prodotto(context, spesa);
  }

  void onLongPress(Spesa spesa) {
    setState(() {
      spesa.id != null ? DatabaseHelper.instance.rimuovi(spesa.id!) : null;
    });
  }
}

import 'package:flutter/material.dart';
import '../model/spesa.dart';

class ListBuilder{

  static Widget build_list(List<Spesa> data, Function onTap, Function onLongPress) {
    return ListView(
      children: data.map((spesa) {
        return build_list_tile(spesa, onTap, onLongPress);
      }).toList(),
    );
  }

  static Widget build_list_tile(Spesa spesa, Function onTap, Function onLongPress) {
    int selectedId = -1;
    return Center(
      child: Card(
        color: selectedId == spesa.id ? Colors.white70 : Colors.white,
        child: ListTile(
          title: spesa.articolo != null
              ? Text(spesa.articolo as String)
              : Text(''),
          onTap: () {
            onTap(spesa);
          },
          onLongPress: () {
            onLongPress(spesa);
          },
        ),
      ),
    );
  }
}

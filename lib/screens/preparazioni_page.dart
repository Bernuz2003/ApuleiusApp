import 'package:flutter/material.dart';
import '../helper/db_helper.dart';
import 'custom_page.dart';

class PreparazioniPage extends CustomPage {
  PreparazioniPage({Key? key}) : super(key: key, title: 'PREPARAZIONI', getDataFunction: (String query) => DatabaseHelper.instance.getPreparazioni());
}
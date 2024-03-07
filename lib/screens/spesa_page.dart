import 'package:flutter/material.dart';
import '../helper/db_helper.dart';
import 'custom_page.dart';

class SpesaPage extends CustomPage {
  SpesaPage({Key? key}) 
  : super(
      key: key, 
      title: 'SPESA', 
      getDataFunction: (String query) => DatabaseHelper.instance.getCompere());
}
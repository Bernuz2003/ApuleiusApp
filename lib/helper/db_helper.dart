import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import '../model/spesa.dart';
import '../utils/utils.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'spesa.db');

  final exists = await databaseExists(path);

  if (!exists) {
    print("Creazione di una copia del database da assets");

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (error) {
      print("Errore durante la creazione della directory: $error");
    }

    try {
      final ByteData data = await rootBundle.load(join("assets", "spesa.db"));
      final List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      print("Database copiato!");
    } catch (error) {
      print("Errore durante la copia del database: $error");
    }
  } else {
    print("Il database esiste già");
  }

  return openDatabase(path, version: 1);
}


  Future<List<Spesa>> getTabella() async {
    Database db = await instance.database;
    var elementi = await db.query(table_spesa, orderBy: column_id);
    List<Spesa> tabella = elementi.isNotEmpty 
      ? elementi.map((e) => Spesa.fromMap(e)).toList()
      : [];

    return tabella;
  }
  Future<Spesa?> getElemento(int id) async {
    Database db = await instance.database;
    var elementi = await db.query(table_spesa,
                                  where: '$column_id = ?',
                                  whereArgs: [id]);
    if(elementi.isNotEmpty) {
      return Spesa.fromMap(elementi.first);
    }
    else {
      return null;
    }
  }

  Future<List<Spesa>> getElementoByNome(String nome) async {
    Database db = await instance.database;
    var elementi = await db.rawQuery('SELECT * FROM $table_spesa WHERE $column_articolo LIKE ?', ['%$nome%']);

    List<Spesa> tabella = elementi.isNotEmpty
    ? elementi.map((e) => Spesa.fromMap(e)).toList()
    : [];

    return tabella;
  }

  Future<List<Spesa>> getPreparazioni() async {
    Database db = await instance.database;
    var preparazioni = await db.query(table_spesa,
                                where: '$column_fornitore = ?',
                                whereArgs: ['TODO'],
                                orderBy: column_id);

    List<Spesa> tabella = preparazioni.isNotEmpty
      ? preparazioni.map((e) => Spesa.fromMap(e)).toList()
      : [];

    return tabella;
  }

  Future<List<Spesa>> getCompere() async {
    Database db = await instance.database;
    var compere = await db.query(table_spesa,
                                where: '$column_fornitore != ?',
                                whereArgs: ['TODO'],
                                orderBy: column_id);

    List<Spesa> tabella = compere.isNotEmpty
      ? compere.map((e) => Spesa.fromMap(e)).toList()
      : [];

    return tabella;
  }

  int getLenght(List<Spesa> lista) {
    return lista.length;
  }

  Future<int> aggiungi(Spesa spesa) async {
    Database db = await instance.database;
    return await db.insert(table_spesa, spesa.toMap());
  }

  Future<int> rimuovi(int id) async {
    Database db = await instance.database;
    return await db.delete(table_spesa, where: '$column_id = ?', whereArgs: [id]);
  }

  Future<int> aggiorna(Spesa spesa) async {
    Database db = await instance.database;
    return await db.update(table_spesa, spesa.toMap(), 
                           where: '$column_id = ?', 
                           whereArgs: [spesa.id]);
  }
}
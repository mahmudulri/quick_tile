import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_tile/database/database_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'customer.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _oncreate,
    );
  }

  Future _oncreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favourite(id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT)
      ''');
  }

  Future<int> addData(DatabaseModel databaseModel) async {
    Database db = await instance.database;
    return await db.insert("favourite", databaseModel.toMap());
  }

  Future<List<DatabaseModel>> getmyData() async {
    Database db = await instance.database;

    var customer = await db.query("favourite", orderBy: "id");

    List<DatabaseModel> customerList = customer.isNotEmpty
        ? customer.map((data) => DatabaseModel.fromMap(data)).toList()
        : [];
    return customerList;
  }

  Future<int> deleteData(int id) async {
    Database db = await instance.database;
    return await db.delete("favourite", where: "id = ?", whereArgs: [id]);
  }
}

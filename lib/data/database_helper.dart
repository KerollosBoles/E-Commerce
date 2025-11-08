import 'dart:async';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static const _databaseName = 'tire_store.db';
  static const _databaseVersion = 1;

  static const userTable = 'users';
  static const tireTable = 'tires';
  static const saleTable = 'sales';

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $userTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tireTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tire_name TEXT NOT NULL,
        brand TEXT NOT NULL,
        tire_type TEXT NOT NULL,
        supplier TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        purchase_date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $saleTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tire_id INTEGER NOT NULL,
        buyer_name TEXT NOT NULL,
        seller_name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        sale_date TEXT NOT NULL,
        FOREIGN KEY (tire_id) REFERENCES $tireTable(id)
      )
    ''');
  }

  Future<int> registerUser(Map<String, dynamic> user) async {
    final db = await database;
    return db.insert(userTable, user);
  }

  Future<Map<String, dynamic>?> authenticate(
      String email, String password) async {
    final db = await database;
    final result = await db.query(userTable,
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (result.isEmpty) return null;
    return result.first;
  }

  Future<List<Map<String, dynamic>>> getRoles() async {
    final db = await database;
    return db.query(userTable, columns: ['role'], distinct: true);
  }

  Future<int> addTire(Map<String, dynamic> tire) async {
    final db = await database;
    return db.insert(tireTable, tire);
  }

  Future<List<Map<String, dynamic>>> getTires() async {
    final db = await database;
    return db.query(tireTable, orderBy: 'tire_name ASC');
  }

  Future<Map<String, dynamic>?> getTireById(int id) async {
    final db = await database;
    final result = await db.query(tireTable, where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) return null;
    return result.first;
  }

  Future<void> updateTireQuantity(int id, int newQuantity) async {
    final db = await database;
    await db.update(tireTable, {'quantity': newQuantity},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> addSale(Map<String, dynamic> sale) async {
    final db = await database;
    return db.insert(saleTable, sale);
  }

  Future<List<Map<String, dynamic>>> getSales() async {
    final db = await database;
    return db.rawQuery('''
      SELECT s.id, s.buyer_name, s.seller_name, s.quantity, s.price, s.sale_date,
             t.tire_name, t.brand
      FROM $saleTable s
      JOIN $tireTable t ON t.id = s.tire_id
      ORDER BY s.sale_date DESC
    ''');
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}

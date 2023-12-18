library security;

import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class SecurityClient {
  static const String _keysTable = "keys";
  static const String _keysTableKeyColumn = "key";
  static const String _keysTableValueColumn = "value";

  final Database _database;

  SecurityClient._(final Database database) : _database = database;

  static Future<SecurityClient> create(final String name, final String password) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), "$name.db"),
      password: password,
      version: 1,
      onCreate: (database, version) {
        return database.execute(
          "CREATE TABLE $_keysTable($_keysTableKeyColumn TEXT PRIMARY KEY, $_keysTableValueColumn TEXT)",
        );
      },
    );
    return SecurityClient._(database);
  }

  Future<void> add(final String key, final String value) async {
    final database = _database;
    await database.insert(
      _keysTable,
      {_keysTableKeyColumn: key, _keysTableValueColumn: value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, String>> getAll() async {
    final database = _database;
    final List<Map> values = await database.query(_keysTable);

    print("BRUNO: Encoded values: $values");

    final Map<String, String> map = {};

    for (var element in values) {
      map[element[_keysTableKeyColumn]] = element[_keysTableValueColumn];
    }

    return map;
  }

  Future<String?> getOne(final String key) async {
    final database = _database;
    final List<Map> values = await database.query(
      _keysTable,
      columns: [_keysTableKeyColumn],
      where: "$_keysTableKeyColumn = ?",
      whereArgs: [key],
      limit: 1,
    );

    return values.firstOrNull?[_keysTableValueColumn];
  }

  Future<void> delete(final String key) async {
    final database = _database;
    await database.delete(
      _keysTable,
      where: "$_keysTableKeyColumn = ?",
      whereArgs: [key],
    );
  }

  Future<void> destroy() async {
    final database = _database;
    await deleteDatabase(database.path);
  }
}

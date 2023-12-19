library security;

import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

/// [SecurityClient] class.
///
/// All of the available methods to store and manage encrypted keys are going to be available through this class.
///
/// An instance can be created through calling the method [create].
class SecurityClient {
  static const String _keysTable = "keys";
  static const String _keysTableKeyColumn = "key";
  static const String _keysTableValueColumn = "value";

  final Database _database;

  SecurityClient._(final Database database) : _database = database;

  /// Creates instance for SecurityClient for [name] with [password].
  /// 
  /// Returns [Future] of [SecurityClient].
  /// If an instance with the given [name] was already created, it will only open the database for it.
  ///
  /// ```
  /// final SecurityClient globalSecurityClient = await SecurityClient.create("global", "...");
  /// final SecurityClient userSecurityClient = await SecurityClient.create("user_1", "...");
  /// ```
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

  /// Add a [key] and [value] pair to the current [SecurityClient] instance database.
  ///
  /// ```
  /// final SecurityClient securityClient = ...;
  /// securityClient.add("secure_key", "12345");
  /// ```
  Future<void> add(final String key, final String value) async {
    final database = _database;
    await database.insert(
      _keysTable,
      {_keysTableKeyColumn: key, _keysTableValueColumn: value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all saved entries in the current [SecurityClient] instance database.
  /// 
  /// Returns a [Map], each element being a pair of key and value.
  ///
  /// ```
  /// final SecurityClient securityClient = ...;
  /// final Map<String, String> entries = await securityClient.getAll();
  /// ```
  Future<Map<String, String>> getAll() async {
    final database = _database;
    final List<Map> values = await database.query(_keysTable);

    final Map<String, String> map = {};

    for (var element in values) {
      map[element[_keysTableKeyColumn]] = element[_keysTableValueColumn];
    }

    return map;
  }

  /// Get a single entry in the current [SecurityClient] instance database.
  /// 
  /// Returns the [String] value if [key] exists. Returns null if it doesn't.
  ///
  /// ```
  /// final SecurityClient securityClient = ...;
  /// final String? secret = await securityClient.getOne("secure_key");
  /// ```
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

  /// Delete a single entry for the specified [key] in the current [SecurityClient] instance database.
  ///
  /// ```
  /// final SecurityClient securityClient = ...;
  /// await securityClient.delete("secure_key");
  /// ```
  Future<void> delete(final String key) async {
    final database = _database;
    await database.delete(
      _keysTable,
      where: "$_keysTableKeyColumn = ?",
      whereArgs: [key],
    );
  }

  /// Delete the database for the current SecurityClient instance.
  ///
  /// ```
  /// final SecurityClient securityClient = ...;
  /// await securityClient.destroy();
  /// ```
  Future<void> destroy() async {
    final database = _database;
    await deleteDatabase(database.path);
  }
}

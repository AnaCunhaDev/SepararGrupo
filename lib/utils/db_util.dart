import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static Future<sql.Database> database(String ddl) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'sorteio.db'),
      onCreate: (db, version) {
        return db.execute(ddl);
      },
      version: 1,
    );
  }

  static Future<void> insert(
      String table, Map<String, Object> data, String ddl) async {
    final db = await DbUtil.database(ddl);
    await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(
      String table, String ddl) async {
    final db = await DbUtil.database(ddl);
    return db.query(table);
  }

  static Future<void> delete(
      String table, String where, List<dynamic> args, String ddl) async {
    final db = await DbUtil.database(ddl);
    db.delete(table, where: where, whereArgs: args);
  }

  static Future<void> deleteAll(String table, String ddl) async {
    final db = await DbUtil.database(ddl);
    db.delete(table);
  }

  static Future<void> update(String table, Map<String, Object> data, String ddl,
      String where, List<dynamic> args) async {
    final db = await DbUtil.database(ddl);
    db.update(table, data, where: where, whereArgs: args);
  }
}

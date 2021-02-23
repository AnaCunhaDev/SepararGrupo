import 'package:SepararGrupos/utils/db_util.dart';

class PersonData {
  static final String ddl =
      'CREATE TABLE persons (id TEXT PRIMARY KEY, nome TEXT, classificacao INTERGER, idade INTEGER, isActive INTEGER, group INTEGER)';
  static final String table = 'persons';

  static Future<void> insert(Map<String, Object> data) async {
    await DbUtil.insert(table, data, ddl);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    return await DbUtil.getData(table, ddl);
  }

  static Future<void> delete(List<dynamic> args, String where) async {
    await DbUtil.delete(table, where, args, ddl);
  }

  static Future<void> deleteAll() async {
    await DbUtil.deleteAll(table, ddl);
  }

  static Future<void> updateIsActiveAll(Map<String, Object> data) async {
    String where = 'isActive = ?';
    await DbUtil.update(table, data, ddl, where, [1]);
  }

  static Future<void> updatebyId(Map<String, Object> data, String id) async {
    String where = 'id = ?';
    await DbUtil.update(table, data, ddl, where, [id]);
  }
}

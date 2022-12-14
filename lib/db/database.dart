import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:volunteer/model/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;
  static const _authTable = 'Auths';
  static const _authId = 'id';
  static const _authAccessColumn = 'access_token';
  static const _authLoginColumn = 'login';
  static const _authRoleColumn = 'role';
  static const _firstName = 'first_name';
  static const _secondName = 'second_name';
  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'volunteer.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_authTable($_authId INTEGER PRIMARY KEY AUTOINCREMENT, $_authAccessColumn TEXT, $_authLoginColumn TEXT, $_authRoleColumn TEXT, $_firstName TEXT, $_secondName TEXT)');
  }

  Future<DBUser> getDBAuth() async {
    Database db = await database;
    final List<Map<String, dynamic>> authMapList = await db.query(_authTable);
    final List<DBUser> authList = [];
    DBUser testUser = DBUser(0, '', '', '', '', '');
    authMapList.forEach((element) {
     testUser = (DBUser.fromMap(element));
    });
    return testUser;
  }

  Future<DBUser> insertAuth(DBUser auth) async {
    Database db = await database;
    auth.id = await db.insert(_authTable, auth.toMap());
    return auth;
  }

  Future<int> updateAuth(DBUser auth) async {
    Database db = await database;
    return await db.update(_authTable, auth.toMap(),
        where: '$_authId=?', whereArgs: [auth.id]);
  }

  Future<int> deleteAuth(int id) async {
    Database db = await database;
    return await db.delete(_authTable, where: '$_authId=?', whereArgs: [id]);
  }
}

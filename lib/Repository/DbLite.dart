import 'dart:async';
import 'dart:io' as io;

import 'package:belajar_flutter_karywan_app/Model/KaryawanModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbLite{
  static final DbLite _instance = new DbLite.internal();
  factory DbLite() => _instance;

  static Database _db;

  Future<Database> get db async{
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }
  
  DbLite.internal();

  initDb() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "dbbelajar.db");
    var theDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDB;
  }

  //create db table
  void _onCreate(Database db, int version) async{
    String dbCreate = "CREATE TABLE Karyawan(ID INTEGER PRIMARY KEY AUTOINCREMENT, Nama TEXT, Telp TEXT, Email TEXT, Department int, Jabatan int)";
    await db.execute(dbCreate);
    print("sukses crate table: " + dbCreate);
  }

  //simpan data karyawan
  Future<int> saveKaryawan(KaryawanModel karyawanModel) async{
    var dbClient = await db;
    int res = await dbClient.insert("Karyawan", karyawanModel.mapToDbClient());
    return res;
  }

  //select data karyawan
  Future<List<KaryawanModel>> getDataKaryawan() async{
    var dbClient = await db;
    List<KaryawanModel> list = List<KaryawanModel>(); 
    List<Map> res = await dbClient.query("Karyawan");
    list = res.map((i) => KaryawanModel.fromMap(i)).toList();
    return list;
  }

  Future<int> deleteKaryawan(id) async{
    var dbClient = await db;
    int res = await dbClient.delete("Karyawan", where: "id = ?", whereArgs: [id]);
    return res;
  }

}
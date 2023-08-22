import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;


class LocalDataBase extends GetxController{
List WholeDataList = [];

  Future get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('Locals.db');
    return _database;
  }

  Future _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE Localdatas(id INTEGER PRIMARY KEY,
DummyDatas JSON NOT NULL
)
''');
  }

  Future addDataLocally({wholedata}) async {
    final db = await database;
    await db.insert("Localdatas", {"DummyDatas": wholedata});
    update();

    // print('${wholedata} Added to databaese succesfuly');
    return 'added';
  }
  

  Future readAllData() async {
    final db = await database;
    final alldata = await db!.query('Localdatas');
    WholeDataList = alldata;
    update();

    // print(WholeDataList);
    return 'Read Succesfully';
  }
}

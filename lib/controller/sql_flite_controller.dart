import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteSqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialDb() async {
    // هذه الداله بتقوم بتحديد مسار حفظ قواعد البيانات في الجهاز باي مجلد تريد حفظ القاعده
    String databasesPath = await getDatabasesPath();

    //  /  هذه عمله انه تساعدك على كتابة رابط والاستغناء عن علامة
    String path = join(databasesPath, 'sqlflite.db');

    // الان الدله المسؤوله على انشاء قواعد البيانات
    // open the database
    Database database = await openDatabase(path,
        version: 1, // when you called onUpgrade will called version .
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);

    return database;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute("ALTER TABLE Notes ADD COLUMN subtitle TEXT");
  }

  _onCreate(Database db, int version) async {
    // When creating the db, create the table
    // await db.execute(
    //     "CREATE TABLE Notes(id INTEGER PRIMARY KEY,note TEXT NOT NULL,title TEXT NOT NULL,color TEXT NOT NULL)");
    // print('onCreate function has called');
    //
    //
// TO CREATE MORE THAN TABLE USE BATCH IS BETTER THAN  db.execute
    Batch batch = db.batch();
    batch.execute('''CREATE TABLE Notes(id INTEGER PRIMARY KEY
                                       ,note TEXT NOT NULL,title TEXT NOT NULL
                                       ,color TEXT NOT NULL,subtitle TEXT NOT NULL)
                                       ''');
    batch.execute('''CREATE TABLE Mobiles(id INTEGER PRIMARY KEY
                                       ,name TEXT NOT NULL,model TEXT NOT NULL
                                       ,company TEXT NOT NULL)
                                       ''');
    await batch.commit();
  }

  readData(String sql) async {
    Database? myData = await db;
    return myData!.rawQuery(sql);
  }

  insertData(String sql) async {
    Database? myData = await db;
    Future<int> response = myData!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myData = await db;
    Future<int> response = myData!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myData = await db;
    Future<int> response = myData!.rawDelete(sql);
    return response;
  }

  static deleteDataBase() async {
    String databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'sqlflite.db');
    await deleteDatabase(path);
  }

  // second way to deal with CRUD in sqlflite and it's the better way
  read(String table) async {
    Database? myData = await db;
    return myData!.query(table);
  }

  insert(String table, Map<String, Object?> values) async {
    Database? myData = await db;
    Future<int> response = myData!.insert(table, values);
    return response;
  }

  update(
      {required String table,
      required Map<String, Object?> values,
      String? where}) async {
    Database? myData = await db;
    Future<int> response = myData!.update(table, values, where: where);
    return response;
  }

  delete({required String table, String? where}) async {
    Database? myData = await db;
    Future<int> response = myData!.delete(table, where: where);
    return response;
  }
}

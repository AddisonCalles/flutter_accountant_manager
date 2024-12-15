import 'package:accountant_manager/application/ports/database_port.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSQLiteAdapter extends DatabasePort<Database> {
  Database? _database;
  final String _name;
  final int _version;
  DatabaseSQLiteAdapter(this._name, this._version, super.migrations);

  @override
  Future<Database> get instance async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  @override
  Future<bool> tableExists( String tableName) async {
    var result = await (await instance).rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return result.isNotEmpty;
  }

  @override
  Future<bool> databaseExists(String path) async {
    return databaseFactory.databaseExists(path);
  }

  @override
  Future<Database> initDatabase() async {
    print('Getting database $_name.db');
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$_name.db');
    if(await databaseExists(path)){
      return await openDatabase(path, version: _version);
    }
    print('Creating database $_name.db');
    return await openDatabase(path, version: _version);
  }

}

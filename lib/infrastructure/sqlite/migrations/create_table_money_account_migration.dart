import 'package:accountant_manager/application/ports/database_migration_port.dart';
import 'package:accountant_manager/application/ports/database_port.dart';
import 'package:accountant_manager/infrastructure/sqlite/commons/columns.dart';
import 'package:sqflite/sqflite.dart';

class CreateTableMoneyAccountMigration extends DatabaseMigrationPort<Database>{

  static String table = 'money_accounts';
  @override
  Future<void> migrate(DatabasePort<Database> database) async {
    Database instance = (await database.instance);
    if(!await database.tableExists(table)) {
      await instance.execute('''
        CREATE TABLE $table (
          $uuidPrimaryColumn,
          title TEXT NOT NULL,
          description TEXT NULL,
          accountType INTEGER NOT NULL,
          balance REAL NOT NULL,
          bank INTEGER NULL,
          accountNumber TEXT NULL,
          $datesColumns
        );
      ''');
      print('Table $table created');

    }else{
      print('Table $table already exists');
    }
  }


  @override
  Future<void> rollback(DatabasePort<Database> database) async {
    Database instance = (await database.instance);
    await instance.execute('''DROP TABLE IF EXISTS $table''');
  }

}
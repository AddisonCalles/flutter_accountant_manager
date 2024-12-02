import 'package:accountant_manager/application/ports/database_migration_port.dart';
import 'package:accountant_manager/application/ports/database_port.dart';
import 'package:accountant_manager/infrastructure/sqlite/commons/columns.dart';
import 'package:sqflite/sqflite.dart';

class CreateTableMoneyTransactionMigration extends DatabaseMigrationPort<Database>{

  static String table = 'money_transactions';
  @override
  Future<void> migrate(DatabasePort<Database> database) async {
    Database instance = (await database.instance);
    if(!await database.tableExists(table)) {
      await instance.execute('''
        CREATE TABLE $table (
          $uuidPrimaryColumn,
          fromAccountUuid TEXT NULL,
          toAccountUuid TEXT NULL,
          spentUuid TEXT NULL,
          amount REAL NOT NULL,
          concept TEXT NULL,
          status INTEGER NOT NULL,
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
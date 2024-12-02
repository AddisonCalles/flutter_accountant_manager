import 'package:accountant_manager/application/ports/database_migration_port.dart';
import 'package:accountant_manager/application/ports/database_port.dart';
import 'package:accountant_manager/infrastructure/adapters/database_sqlite_adapter.dart';
import 'package:accountant_manager/infrastructure/sqlite/migrations/create_table_money_account_migration.dart';
import 'package:sqflite/sqflite.dart';

final List<DatabaseMigrationPort<Database>> migrations = [
  CreateTableMoneyAccountMigration(),
];



class SQLiteDatabaseFactory {
  static DatabasePort<Database>? _instance;
  static DatabasePort<Database> getInstance(){
    return _instance ??= DatabaseSQLiteAdapter('accountant_manager', 1, migrations);
  }
}
import 'package:accountant_manager/application/ports/database_migration_port.dart';

abstract class DatabasePort<Database> {
  Future<Database>  initDatabase();
  final List<DatabaseMigrationPort<Database>> _migrations;

  DatabasePort(this._migrations);

  Future<void> runMigrations(int? version) async {

    for (var migration in migrations) {
      await migration.migrate(this);
    }
  }
  Future<bool> tableExists(String tableName) ;
  Future<bool> databaseExists(String path);
  Future<Database> get instance;

  List<DatabaseMigrationPort<Database>> get migrations {
    return _migrations;
  }



}
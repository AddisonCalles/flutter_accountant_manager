
import 'package:accountant_manager/application/ports/database_port.dart';

abstract class DatabaseMigrationPort<Connection> {
   Future<void> migrate(DatabasePort<Connection> database);
   Future<void> rollback(DatabasePort<Connection> database);
}
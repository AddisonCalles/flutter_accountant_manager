import 'package:accountant_manager/application/ports/database_port.dart';
import 'package:accountant_manager/domain/ports/data_transaction_port.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDataTransactionAdapter implements DataTransactionPort<Transaction> {

  final DatabasePort<Database> db;
  SQLiteDataTransactionAdapter(this.db);

  @override

  @override
  Future<void> transaction(Future<void> Function(Transaction context) callback) async {
   Database sqliteDatabase =  await db.instance;
    await sqliteDatabase.transaction((Transaction txn) async {
      print("Transaction started");
      await callback(txn);
      print("Transaction ended");
    });
  }
  
}
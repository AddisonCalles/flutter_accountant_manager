import 'package:accountant_manager/application/ports/database_port.dart';
import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/domain/exceptions/not_found_entity_of_data.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';
import 'package:accountant_manager/domain/repositories/money_transaction_repository.dart';
import 'package:accountant_manager/domain/values/account_types.dart';
import 'package:accountant_manager/domain/values/banks.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';
import 'package:sqflite/sqflite.dart';

class MoneyTransactionSqliteRepository extends MoneyTransactionRepository {
  final DatabasePort<Database> _databasePort;
  final String _tableName = "money_transactions";
  final Transaction? _transaction;

  MoneyTransactionSqliteRepository(this._databasePort): _transaction = null;

  MoneyTransactionSqliteRepository._withTransaction(
      this._databasePort, this._transaction);

  MoneyTransactionSqliteRepository withTransaction(Transaction transaction) {
    return MoneyTransactionSqliteRepository._withTransaction(_databasePort, transaction);
  }

  MoneyTransaction _parseEntity(Map<String, Object?> entity) {
    return MoneyTransaction(
        uuid: entity["uuid"] as String,
        created: DateTime.parse(entity["created"] as String),
        deleted: entity["deleted"] == null
            ? null
            : DateTime.parse(entity["deleted"] as String),
        updated: entity["updated"] == null
            ? null
            : DateTime.parse(entity["updated"] as String),
        status: MoneyTransactionStatus.values[entity["status"] as int],
        amount: entity["amount"] as double,
        spentUuid: entity["spentUuid"] as String,
        fromAccountUuid: entity["fromAccountUuid"] as String,
        toAccountUuid: entity["toAccountUuid"] as String,
        concept: entity["concept"] as String);
  }

  @override
  Future<bool> create(MoneyTransaction item) async {
    Database db = await _databasePort.instance;
    Map<String, Object?> entityMap = {
      "uuid": item.uuid,
      "fromAccountUuid": item.fromAccountUuid,
      "toAccountUuid":item.toAccountUuid,
      "spentUuid": item.spentUuid,
      "status": item.status.value,
      "concept": item.concept,
      "amount": item.amount,
      "created": item.created!.toIso8601String(),
    };
    if (_transaction != null) {
      await _transaction.insert(_tableName, entityMap);
    } else {
      await db.transaction((txn) async {
        await txn.insert(_tableName, entityMap);
      });
    }
    return true;
  }


  @override
  Future<MoneyTransaction> getByUUID(String uuid) async {
    Database db = await _databasePort.instance;

    List<Map<String, Object?>> results =
        await db.query(_tableName, where: "uuid = ?", whereArgs: [uuid]);

    if (results.isEmpty) {
      throw NotFoundEntityOfData("La cuenta no existe.");
    }
    return _parseEntity(results.first);
  }

  @override
  Future<List<MoneyTransaction>> search(MoneyTransactionFilter filter) async {
    Database db = await _databasePort.instance;

    List<String> where = [];
    List whereArgs = [];


    if (filter.isDeleted != null) {
      if (filter.isDeleted == true) {
        where.add("deleted IS NOT NULL");
      } else {
        where.add("deleted IS NULL");
      }
    }

    if (filter.status != null) {
      where.add("status = ?");
      whereArgs.add(filter.status!.value);
    }
    if (filter.endCreated != null) {
      where.add("created < ?");
      whereArgs.add(filter.endCreated!.toIso8601String());
    }
    if (filter.startCreated != null) {
      where.add("created > ?");
      whereArgs.add(filter.startCreated!.toIso8601String());
    }

    // Modify the query to include pagination with LIMIT and OFFSET
    List<Map<String, Object?>> results = await db.query(
      _tableName,
      where: where.join(" AND "),
      whereArgs: whereArgs,
      limit: filter.pageSize,
      offset: filter.offset,
    );
    if (results.isEmpty) {
      return [];
    }
    return  results.map((e) => _parseEntity(e)).toList();
  }

  Future<void> _update(MoneyTransaction moneyAccount, Transaction txn) async {
    await txn.update(_tableName, {
      "uuid": moneyAccount.uuid,
      "fromAccountUuid": moneyAccount.fromAccountUuid,
      "toAccountUuid":moneyAccount.toAccountUuid,
      "spentUuid": moneyAccount.spentUuid,
      "status": moneyAccount.status.value,
      "concept": moneyAccount.concept,
      "amount": moneyAccount.amount,
      "updated": DateTime.now().toIso8601String(),
    }, where: "uuid = ?", whereArgs: [moneyAccount.uuid]);
  }

  @override
  Future<bool> update(MoneyTransaction moneyTransaction) async {
    if (_transaction != null) {
      await _update(moneyTransaction, _transaction);
    } else {
      Database db = await _databasePort.instance;
      await db.transaction((txn) async {
        await _update(moneyTransaction, txn);
      });
    }
    return true;
  }
}

import 'package:accountant_manager/application/ports/database_port.dart';
import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/domain/exceptions/not_found_entity_of_data.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';
import 'package:accountant_manager/domain/values/account_types.dart';
import 'package:accountant_manager/domain/values/banks.dart';
import 'package:sqflite/sqflite.dart';

class MoneyAccountSqliteRepository extends MoneyAccountRepository {
  final DatabasePort<Database> _databasePort;
  final String _tableName = "money_accounts";
  final Transaction? _transaction;

  MoneyAccountSqliteRepository(this._databasePort): _transaction = null;

  MoneyAccountSqliteRepository._withTransaction(
      this._databasePort, this._transaction);

  MoneyAccountSqliteRepository withTransaction(Transaction transaction) {
    return MoneyAccountSqliteRepository._withTransaction(_databasePort, transaction);
  }

  MoneyAccount _parseEntity(Map<String, Object?> entity) {
    return MoneyAccount(
        uuid: entity["uuid"] as String,
        created: DateTime.parse(entity["created"] as String),
        deleted: entity["deleted"] == null
            ? null
            : DateTime.parse(entity["deleted"] as String),
        updated: entity["updated"] == null
            ? null
            : DateTime.parse(entity["updated"] as String),
        accountType: MoneyAccountTypes.values[entity["accountType"] as int],
        balance: entity["balance"] as double,
        bank:  entity["bank"] == null ? null: Banks.values[entity["bank"] as int],
        accountNumber: entity["accountNumber"] as String,
        title: entity["title"] as String,
        description: entity["description"] == null ? null : entity["description"] as String);
  }

  @override
  Future<bool> create(MoneyAccount moneyAccount) async {
    Database db = await _databasePort.instance;
    Map<String, Object?> moneyAccountMap = {
      "uuid": moneyAccount.uuid,
      "title": moneyAccount.title,
      "accountType": moneyAccount.accountType.value,
      "balance": moneyAccount.balance,
      "bank": moneyAccount.bank?.value,
      "accountNumber": moneyAccount.accountNumber,
      "description": moneyAccount.description,
      "created": moneyAccount.created!.toIso8601String(),
    };
    if (_transaction != null) {
      await _transaction.insert(_tableName, moneyAccountMap);
    } else {
      await db.transaction((txn) async {
        await txn.insert(_tableName, moneyAccountMap);
      });
    }
    return true;
  }


  @override
  Future<MoneyAccount> getByUUID(String uuid) async {
    Database db = await _databasePort.instance;

    List<Map<String, Object?>> results =
        await db.query(_tableName, where: "uuid = ?", whereArgs: [uuid]);

    if (results.isEmpty) {
      throw NotFoundEntityOfData("La cuenta no existe.");
    }
    return _parseEntity(results.first);
  }

  @override
  Future<List<MoneyAccount>> search(MoneyAccountFilter filter) async {
    Database db = await _databasePort.instance;

    List<String> where = [];
    List whereArgs = [];

    if (filter.title != null) {
      where.add("title LIKE ?");
      whereArgs.add("%${filter.title}%");
    }
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

  Future<void> _update(MoneyAccount moneyAccount, Transaction txn) async {
    await txn.update(_tableName, {
      "uuid": moneyAccount.uuid,
      "title": moneyAccount.title,
      "description": moneyAccount.description,
      "accountType": moneyAccount.accountType.value,
      "balance": moneyAccount.balance,
      "bank": moneyAccount.bank?.value,
      "accountNumber": moneyAccount.accountNumber,
      "updated": DateTime.now().toIso8601String(),
    }, where: "uuid = ?", whereArgs: [moneyAccount.uuid]);
  }

  @override
  Future<bool> update(MoneyAccount moneyAccount) async {
    if (_transaction != null) {
      await _update(moneyAccount, _transaction);
    } else {
      Database db = await _databasePort.instance;
      await db.transaction((txn) async {
        await _update(moneyAccount, txn);
      });
    }
    return true;
  }
}

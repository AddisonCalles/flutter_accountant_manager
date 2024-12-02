import 'package:accountant_manager/domain/entities/auditable.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';

class MoneyTransaction extends Auditable {

  final String fromAccountUuid;
  final String? toAccountUuid;
  final String? spentUuid;
  final String? concept;
  final double amount;
  final MoneyTransactionStatus status;

  const MoneyTransaction({
    super.uuid,
    this.toAccountUuid,
    this.spentUuid,
    this.concept,
    required this.fromAccountUuid,
    required this.amount,
    required this.status,
    super.created,
    super.deleted,
    super.updated,
    super.serverCreated,
    super.serverUpdated,
    super.pendingSync,
  });

  MoneyTransaction copyWith({
    String? uuid,
    String? fromAccountUuid,
    String? spentUuid,
    String? toAccountUuid,
    String? concept,
    double? amount,
    MoneyTransactionStatus? status,
    DateTime? created,
    DateTime? updated,
    DateTime? deleted,
    DateTime? serverCreated,
    DateTime? serverUpdated,
    bool? pendingSync,
  }) {
    return MoneyTransaction(
      uuid: uuid ?? super.uuid,
      fromAccountUuid: fromAccountUuid ?? this.fromAccountUuid,
      toAccountUuid: toAccountUuid ?? this.toAccountUuid,
      spentUuid: spentUuid ?? this.spentUuid,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      concept: concept ?? this.concept,
      created: created ?? super.created,
      updated: updated ?? super.updated,
      deleted: deleted ?? super.deleted,
      serverCreated: serverCreated ?? super.serverCreated,
      serverUpdated: serverUpdated ?? super.serverUpdated,
      pendingSync: pendingSync ?? super.pendingSync,
    );
  }

  @override
  List<Object?> get props =>[
    uuid,
    fromAccountUuid,
    toAccountUuid,
    spentUuid,
    concept,
    amount,
    status,
    created,
    updated,
    deleted,
    serverCreated,
    serverUpdated,
    pendingSync
  ];
}
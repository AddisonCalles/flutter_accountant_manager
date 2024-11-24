import 'package:accountant_manager/domain/entities/auditable_filter.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';

class MoneyTransactionFilter extends AuditableFilter {
  final String? accountUUID;
  final MoneyTransactionStatus? status;

  const MoneyTransactionFilter(
      {
        this.accountUUID,
        this.status,
        super.startCreated,
        super.endCreated,
        required super.page,
        required super.pageSize});

  factory MoneyTransactionFilter.clean() {
    return const MoneyTransactionFilter(
        accountUUID: null,
        status: null,
        startCreated: null,
        endCreated: null,
        page: 0,
        pageSize: 10);
  }
  
  @override
  List<Object?> get props => [
        accountUUID,
        status,
        super.startCreated,
        super.endCreated,
        super.page,
        super.pageSize
      ];

  @override
  MoneyTransactionFilter copyWith(
      {
        String? accountUUID,
        MoneyTransactionStatus? status,
        DateTime? startCreated,
        DateTime? endCreated,
        bool? isPaid,
        bool? isDeleted,
        int? page,
        int? pageSize}) {
    return MoneyTransactionFilter(
        accountUUID: accountUUID ?? this.accountUUID,
        status: status ?? this.status,
        startCreated: startCreated ?? this.startCreated,
        endCreated: endCreated ?? this.endCreated,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize);
  }
}

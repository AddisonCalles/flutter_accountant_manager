import 'package:accountant_manager/domain/entities/auditable_filter.dart';
import 'package:accountant_manager/domain/values/money_account_status.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';

class MoneyAccountFilter extends AuditableFilter {
  final String? accountUUID;
  final MoneyAccountStatus? status;

  const MoneyAccountFilter(
      {
        this.accountUUID,
        this.status,
        super.startCreated,
        super.endCreated,
        required super.page,
        required super.pageSize});

  factory MoneyAccountFilter.clean() {
    return const MoneyAccountFilter(
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
  MoneyAccountFilter copyWith(
      {
        String? accountUUID,
        MoneyAccountStatus? status,
        DateTime? startCreated,
        DateTime? endCreated,
        bool? isPaid,
        bool? isDeleted,
        int? page,
        int? pageSize}) {
    return MoneyAccountFilter(
        accountUUID: accountUUID ?? this.accountUUID,
        status: status ?? this.status,
        startCreated: startCreated ?? this.startCreated,
        endCreated: endCreated ?? this.endCreated,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize);
  }
}

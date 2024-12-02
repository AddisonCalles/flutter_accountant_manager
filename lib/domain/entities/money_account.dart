import 'package:accountant_manager/domain/entities/auditable.dart';
import 'package:accountant_manager/domain/values/account_types.dart';
import 'package:accountant_manager/domain/values/banks.dart';
import 'package:intl/intl.dart';
final String deviceLocale = Intl.getCurrentLocale();
final NumberFormat currencyFormatter = NumberFormat.currency(
  locale: deviceLocale,
  symbol: '\$', // Opcional: deja que el símbolo sea definido por el locale
);
class MoneyAccount extends Auditable{
  final double balance;
  final MoneyAccountTypes accountType;
  final String? title;
  final String? description;
  final Banks? bank;
  final String? accountNumber;


  const MoneyAccount({
    super.uuid,
    required this.balance,
    required this.accountType,
    this.title,
    this.description,
    this.bank,
    this.accountNumber,
    super.created,
    super.deleted,
    super.updated,
    super.serverCreated,
    super.serverUpdated,
    super.pendingSync
  });


  MoneyAccount copyWith({
    String? uuid,
    String? title,
    String? description,
    Banks? bank,
    String? accountNumber,
    MoneyAccountTypes? accountType,
    double? balance,
    DateTime? created,
    DateTime? updated,
    DateTime? deleted
  }){
    return MoneyAccount(
        uuid:  uuid ?? this.uuid,
        description: description ?? this.description,
        title: title ?? this.title,
        accountType: accountType ?? this.accountType,
        accountNumber: accountNumber ?? this.accountNumber,
        balance: balance ?? this.balance,
        created: created ?? super.created,
        updated: updated ?? super.updated,
        deleted: deleted ?? super.deleted
    );
  }

  bool get hasAccountNumber => accountNumber != null && accountNumber!.isNotEmpty;

  String balanceFormatted() => balance.toStringAsFixed(2);
  @override
  List<Object?> get props => [
    title,
    description,
    bank,
    accountNumber,
    accountType,
    balance,
    uuid,
    created,
    updated,
    deleted
  ];
}
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/money_transaction_event.dart';

final class CreateMoneyTransactionEvent extends MoneyTransactionEvent {
  final MoneyTransaction account;
  const CreateMoneyTransactionEvent({required this.account});

  @override
  List<Object?> get props => [account];
}
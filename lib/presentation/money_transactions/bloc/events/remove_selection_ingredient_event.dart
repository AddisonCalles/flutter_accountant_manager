import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/money_transaction_event.dart';

class RemoveSelectionMoneyTransactionEvent extends MoneyTransactionEvent {
  final MoneyTransaction transaction;

  const RemoveSelectionMoneyTransactionEvent(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
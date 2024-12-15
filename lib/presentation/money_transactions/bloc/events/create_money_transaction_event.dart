import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/money_transaction_event.dart';

final class CreateMoneyTransactionEvent extends MoneyTransactionEvent {
  final MoneyTransaction transaction;
  const CreateMoneyTransactionEvent({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}
import 'package:accountant_manager/presentation/money_accounts/bloc/events/money_account_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/money_transaction_event.dart';


class ClearSelectionMoneyAccountEvent extends MoneyAccountEvent {
  const ClearSelectionMoneyAccountEvent();
  @override
  List<Object?> get props => [];
}
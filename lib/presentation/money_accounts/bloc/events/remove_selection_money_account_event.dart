import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/money_account_event.dart';

class RemoveSelectionMoneyAccountEvent extends MoneyAccountEvent {
  final MoneyAccount account;

  const RemoveSelectionMoneyAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}
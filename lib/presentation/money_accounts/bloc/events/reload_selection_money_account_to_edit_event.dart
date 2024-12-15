import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/money_account_event.dart';

class ReloadSelectionMoneyAccountToEditEvent extends MoneyAccountEvent {

  const ReloadSelectionMoneyAccountToEditEvent();

  @override
  List<Object?> get props => [];
}
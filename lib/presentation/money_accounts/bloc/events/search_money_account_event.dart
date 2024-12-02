import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/money_account_event.dart';


class SearchMoneyAccountEvent extends MoneyAccountEvent {
  final MoneyAccountFilter? search;
  final bool reload;
  
  const SearchMoneyAccountEvent({required this.search}):
        reload = search == null;

  @override
  List<Object?> get props => [search, reload];

  // make a constructor with tefault values
  const SearchMoneyAccountEvent.clean(): search = const MoneyAccountFilter( page : 1, pageSize : 100), reload = false;
}
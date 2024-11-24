import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/money_transaction_event.dart';


class SearchMoneyTransactionEvent extends MoneyTransactionEvent {
  final MoneyTransactionFilter? search;
  final bool reload;
  
  const SearchMoneyTransactionEvent({required this.search}):
        reload = search == null;

  @override
  List<Object?> get props => [search, reload];

  // make a constructor with tefault values
  const SearchMoneyTransactionEvent.clean(): search = const MoneyTransactionFilter( page : 1, pageSize : 100), reload = false;
}
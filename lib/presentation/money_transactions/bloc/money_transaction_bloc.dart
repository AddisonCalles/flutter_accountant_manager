import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/create_money_transaction_usecase.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/search_money_transaction_usecase.dart';
import 'package:accountant_manager/domain/values/generic_request_status.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/clear_selection_money_transaction_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/create_money_transaction_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/money_transaction_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/search_money_transaction_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/money_transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoneyTransactionBloc extends Bloc<MoneyTransactionEvent, MoneyTransactionState> {
  final CreateMoneyTransactionUseCase _createMoneyTransactionUseCase;
  final SearchMoneyTransactionUseCase _searchMoneyTransactionUseCase;


  MoneyTransactionBloc(
      {required CreateMoneyTransactionUseCase createMoneyTransactionUseCase,
       required SearchMoneyTransactionUseCase searchAccountUseCase})
      : /* Initialize attributes*/
        _createMoneyTransactionUseCase = createMoneyTransactionUseCase,
        _searchMoneyTransactionUseCase = searchAccountUseCase,
        super(MoneyTransactionState(
            isLoading: false,
            lastMoneyTransaction: null,
            moneyTransactions: const [],
            error: '')) {
    on<CreateMoneyTransactionEvent>(_mapMoneyTransactionAddedEventToState);
    on<SearchMoneyTransactionEvent>(_mapSearchMoneyTransactionEventToState);
    on<ClearSelectionMoneyTransactionEvent>(_mapClearSelectionMoneyTransactionEventToState);
  }

  void _mapMoneyTransactionAddedEventToState(
      CreateMoneyTransactionEvent event, Emitter<MoneyTransactionState> emit) async {
    try {
      emit(state.copyWith(
          isLoading: true,
          error: '',
          statusProgress: GenericRequestStatus.started));
      final MoneyTransaction moneyTransaction =
          await _createMoneyTransactionUseCase.execute(event.account);
      emit(state.copyWith(
          isLoading: false,
          error: '',
          lastMoneyTransaction: moneyTransaction,
          statusProgress: GenericRequestStatus.success));
    } /* on IngredientAlreadyExistException catch (e) {
      emit(state.copyWith(
          isLoading: false,
          error: e.message,
          lastIngredient: null,
          statusProgress: GenericRequestStatus.error));
    } */ catch (e) {
      emit(state.copyWith(
          isLoading: false,
          error: "Error inesperado",
          lastMoneyTransaction: null,
          statusProgress: GenericRequestStatus.error));
      rethrow;
    }

  }
  void _mapSearchMoneyTransactionEventToState(
      SearchMoneyTransactionEvent event, Emitter<MoneyTransactionState> emit) async {
    MoneyTransactionFilter? search = event.reload? state.search: event.search;
    if(search == null){
      return;
    }
    try {
      emit(state.copyWith(isLoading: true, error: '', search: search).copyWithoutSelectedToEdit());
      final List<MoneyTransaction> transactions = await _searchMoneyTransactionUseCase
          .execute(search);
      emit(state.copyWith(
          isLoading: false, error: '', moneyTransactions: transactions));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error inesperado", statusProgress: GenericRequestStatus.error));
      rethrow;
    }
  }


  void _mapClearSelectionMoneyTransactionEventToState(
      ClearSelectionMoneyTransactionEvent event, Emitter<MoneyTransactionState> emit) async {
    emit(state.copyWith(selected: const []));
  }

  @override
  Future<void> close() {
    // print("IngredientBloc close");
    return super.close();
  }
}

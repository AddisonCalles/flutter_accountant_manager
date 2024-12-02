import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/domain/usecases/money_account/create_money_account_usecase.dart';
import 'package:accountant_manager/domain/usecases/money_account/search_money_account_usecase.dart';
import 'package:accountant_manager/domain/values/generic_request_status.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/clear_selection_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/create_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/search_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/select_to_update_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoneyAccountBloc extends Bloc<MoneyAccountEvent, MoneyAccountState> {
  final CreateMoneyAccountUseCase _createMoneyAccountUseCase;
  final SearchMoneyAccountUseCase _searchMoneyAccountUseCase;

  MoneyAccountBloc(
      {required CreateMoneyAccountUseCase createMoneyAccountUseCase,
      required SearchMoneyAccountUseCase searchMoneyAccountUseCase})
      : /* Initialize attributes*/
        _createMoneyAccountUseCase = createMoneyAccountUseCase,
        _searchMoneyAccountUseCase = searchMoneyAccountUseCase,
        super(MoneyAccountState(
            isLoading: false,
            lastMoneyAccount: null,
            moneyAccounts: const [],
            error: '')) {
    on<CreateMoneyAccountEvent>(_mapCreateMoneyAccountEventToState);
    on<SearchMoneyAccountEvent>(_mapSearchMoneyAccountEventToState);
    on<ClearSelectionMoneyAccountEvent>(
        _mapClearSelectionMoneyAccountEventToState);
    on<SelectToUpdateMoneyAccountEvent>(_mapSelectToUpdateMoneyAccountEventToState);
  }

  void _mapCreateMoneyAccountEventToState(CreateMoneyAccountEvent event,
      Emitter<MoneyAccountState> emit) async {
          print("CreateMoneyAccountEvent");
    try {
      emit(state.copyWith(
          isLoading: true,
          error: '',
          statusProgress: GenericRequestStatus.started));
      final MoneyAccount moneyAccount =
          await _createMoneyAccountUseCase.execute(event.account);
      emit(state.copyWith(
          isLoading: false,
          error: '',
          lastMoneyAccount: moneyAccount,
          statusProgress: GenericRequestStatus.success));
    }
    /* on IngredientAlreadyExistException catch (e) {
      emit(state.copyWith(
          isLoading: false,
          error: e.message,
          lastIngredient: null,
          statusProgress: GenericRequestStatus.error));
    } */
    catch (e) {
      emit(state.copyWith(
          isLoading: false,
          error: "Error inesperado",
          lastMoneyAccount: null,
          statusProgress: GenericRequestStatus.error));
      rethrow;
    }
  }

  void _mapSearchMoneyAccountEventToState(
      SearchMoneyAccountEvent event, Emitter<MoneyAccountState> emit) async {
    MoneyAccountFilter? search = event.reload ? state.search : event.search;
    if (search == null) {
      return;
    }
    try {
      emit(state
          .copyWith(isLoading: true, error: '', search: search)
          .copyWithoutSelectedToEdit());
      final List<MoneyAccount> transactions =
          await _searchMoneyAccountUseCase.execute(search);
      emit(state.copyWith(
          isLoading: false, error: '', moneyAccounts: transactions));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          error: "Error inesperado",
          statusProgress: GenericRequestStatus.error));
      rethrow;
    }
  }

  void _mapClearSelectionMoneyAccountEventToState(
      ClearSelectionMoneyAccountEvent event,
      Emitter<MoneyAccountState> emit) async {
    emit(state.copyWith(selected: const []));
  }

  void _mapSelectToUpdateMoneyAccountEventToState(SelectToUpdateMoneyAccountEvent event,
      Emitter<MoneyAccountState> emit) async {
    emit(state.copyWith(selectedToEdit: event.account));
  }
  @override
  Future<void> close() {
    // print("IngredientBloc close");
    return super.close();
  }
}

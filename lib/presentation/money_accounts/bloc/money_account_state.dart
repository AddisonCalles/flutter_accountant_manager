import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/domain/values/generic_request_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MoneyAccountState extends Equatable {
  final bool isLoading;

  final MoneyAccount? lastMoneyAccount;
  final MoneyAccount? selectedToEdit;

  final MoneyAccountFilter search;
  final List<MoneyAccount> moneyAccounts;
  final List<MoneyAccount> selected;

  final GenericRequestStatus statusProgress;
  final String error;

  MoneyAccountState(
      {this.isLoading = false,
      MoneyAccountFilter? search,
      this.lastMoneyAccount,
      this.selectedToEdit,
      this.selected = const [],
      this.statusProgress = GenericRequestStatus.unknown,
      this.moneyAccounts = const [],
      this.error = ''})
      : search = search ?? MoneyAccountFilter.clean();

  @override
  List<Object?> get props => [
        isLoading,
        statusProgress,
        lastMoneyAccount,
        moneyAccounts,
        error,
        search,
        selected,
        selectedToEdit,
      ];

  MoneyAccountState copyWithoutSelectedToEdit() {
    return MoneyAccountState(
        statusProgress: statusProgress,
        search: search,
        isLoading: isLoading,
        lastMoneyAccount: lastMoneyAccount,
        moneyAccounts: moneyAccounts,
        selectedToEdit: null,
        selected: selected,
        error: error);
  }

  MoneyAccountState copyWith(
      {bool? isLoading,
      MoneyAccount? lastMoneyAccount,
      List<MoneyAccount>? moneyAccounts,
      List<MoneyAccount>? selected,
      GenericRequestStatus? statusProgress,
      String? error,
      MoneyAccountFilter? search,
      String? uuidCreateRequest}) {
    return MoneyAccountState(
        statusProgress: statusProgress ?? this.statusProgress,
        search: search ?? this.search,
        isLoading: isLoading ?? this.isLoading,
        lastMoneyAccount: lastMoneyAccount ?? this.lastMoneyAccount,
        moneyAccounts: moneyAccounts ?? this.moneyAccounts,
        selected: selected ?? this.selected,
        error: error ?? this.error);
  }
}

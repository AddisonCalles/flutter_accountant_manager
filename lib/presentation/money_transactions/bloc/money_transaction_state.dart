import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/domain/values/generic_request_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MoneyTransactionState extends Equatable {
  final bool isLoading;

  final MoneyTransaction? lastMoneyTransaction;
  final MoneyTransaction? selectedToEdit;

  final MoneyTransactionFilter search;
  final List<MoneyTransaction> moneyTransactions;
  final List<MoneyTransaction> selected;

  final GenericRequestStatus statusProgress;
  final String error;

  MoneyTransactionState(
      {this.isLoading = false,
      MoneyTransactionFilter? search,
      this.lastMoneyTransaction,
      this.selectedToEdit,
      this.selected = const [],
      this.statusProgress = GenericRequestStatus.unknown,
      this.moneyTransactions = const [],
      this.error = ''})
      : search = search ?? MoneyTransactionFilter.clean();

  @override
  List<Object?> get props => [
        isLoading,
        statusProgress,
        lastMoneyTransaction,
        moneyTransactions,
        error,
        search,
        selected,
        selectedToEdit,
      ];

  MoneyTransactionState copyWithoutSelectedToEdit() {
    return MoneyTransactionState(
        statusProgress: statusProgress,
        search: search,
        isLoading: isLoading,
        lastMoneyTransaction: lastMoneyTransaction,
        moneyTransactions: moneyTransactions,
        selectedToEdit: null,
        selected: selected,
        error: error);
  }

  MoneyTransactionState copyWith(
      {bool? isLoading,
      MoneyTransaction? lastMoneyTransaction,
      List<MoneyTransaction>? moneyTransactions,
      List<MoneyTransaction>? selected,
      GenericRequestStatus? statusProgress,
      String? error,
      MoneyTransactionFilter? search,
      String? uuidCreateRequest}) {
    return MoneyTransactionState(
        statusProgress: statusProgress ?? this.statusProgress,
        search: search ?? this.search,
        isLoading: isLoading ?? this.isLoading,
        lastMoneyTransaction: lastMoneyTransaction ?? this.lastMoneyTransaction,
        moneyTransactions: moneyTransactions ?? this.moneyTransactions,
        selected: selected ?? this.selected,
        error: error ?? this.error);
  }
}

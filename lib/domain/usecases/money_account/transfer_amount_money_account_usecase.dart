import 'package:accountant_manager/domain/entities/money_transaction.dart';


abstract class TransferAmountMoneyAccountUsecase {
  Future<MoneyTransaction> execute(MoneyTransaction transaction);
}
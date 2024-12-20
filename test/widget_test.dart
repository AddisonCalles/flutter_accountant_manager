// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:accountant_manager/application/usecases/mocks/money_account/create_money_account_usecase_mock.dart';
import 'package:accountant_manager/application/usecases/mocks/money_account/search_money_account_usecase_mock.dart';
import 'package:accountant_manager/application/usecases/mocks/money_account/transfer_amount_money_account_usecase_mock.dart';
import 'package:accountant_manager/application/usecases/mocks/money_transaction/create_money_transaction_usecase_mock.dart';
import 'package:accountant_manager/application/usecases/mocks/money_transaction/search_money_transaction_usecase_mock.dart';
import 'package:accountant_manager/presentation/main.app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      createMoneyAccountUseCase: CreateMoneyAccountUseCaseMock(),
    searchMoneyTransactionUseCase: SearchMoneyTransactionUseCaseMock(),
    createMoneyTransactionUseCase: CreateMoneyTransactionUseCaseMock(),
    searchMoneyAccountUseCase: SearchMoneyAccountUseCaseMock(),
    transferAmountMoneyAccountUsecase: TransferAmountMoneyAccountUsecaseMock(),));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

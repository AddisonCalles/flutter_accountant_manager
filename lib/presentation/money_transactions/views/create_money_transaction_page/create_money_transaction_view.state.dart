import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/values/account_types.dart';
import 'package:accountant_manager/domain/values/generic_request_status.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';
import 'package:accountant_manager/presentation/commons/interfaces/item_list.dart';
import 'package:accountant_manager/presentation/commons/list_search_selector_dropdown.dart';
import 'package:accountant_manager/presentation/commons/switch_field.dart';
import 'package:accountant_manager/presentation/commons/toggle_buttons_app.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/reload_selection_money_account_to_edit_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_state.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/clear_selection_money_transaction_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/create_money_transaction_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/money_transaction_bloc.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/money_transaction_state.dart';
import 'package:accountant_manager/presentation/money_transactions/views/create_money_transaction_page/create_money_transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/presentation/Layouts/MainLayout/main_layout.dart';

enum MovementType { transfer, deposit, withdraw }

const List<(MovementType, String)> movementOptions = <(MovementType, String)>[
  (MovementType.transfer, "Transferencia"),
  (MovementType.deposit, "Deposito"),
  (MovementType.withdraw, "Retiro"),
];

class CreateMoneyTransactionPageState
    extends State<CreateMoneyTransactionPage> {
  bool finished = false;
  MovementType movement = MovementType.deposit;
  final _formKey = GlobalKey<FormState>();
  ItemList<MoneyAccount>? selectedElement = ItemList<MoneyAccount>('', '', MoneyAccount.empty());
  List<ItemList<MoneyAccount>> accountList = <ItemList<MoneyAccount>>[];
  MoneyTransaction moneyTransaction = const MoneyTransaction(
    amount: 0,
    status: MoneyTransactionStatus.pending,
    concept: '',
  );
  MoneyAccount account = MoneyAccount.empty();
  bool submited = false;

  @override
  void initState() {
    BlocProvider.of<MoneyTransactionBloc>(context)
        .add(const ClearSelectionMoneyTransactionEvent());
    final selectedToEdit = context.read<MoneyAccountBloc>().state.selectedToEdit;
    if (selectedToEdit != null) {
      account = selectedToEdit;
    }
    setState(() {
      accountList = context.read<MoneyAccountBloc>().state
          .moneyAccounts
          .where((element) => element.uuid != account!.uuid)
          .toList()
          .map((e) => ItemList<MoneyAccount>(e.title!, e.uuid!, e))
          .toList();
    });
    if( context.read<MoneyTransactionBloc>().state.selectedToEdit != null) {
      setState(() {
        selectedElement =  accountList.firstWhere(
                (element) => element.value == moneyTransaction.toAccountUuid,
            orElse: () => ItemList<MoneyAccount>('', '', MoneyAccount.empty()));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //select ingredients of the ingredientBloc
    final selectedToEdit = context
        .select((MoneyTransactionBloc bloc) => bloc.state.selectedToEdit);

    if (selectedToEdit != null &&
        moneyTransaction.uuid != selectedToEdit.uuid) {
      /**
       * Sincronizar transacción de vista con el del estado del bloc
       * cuando cambia la transacción seleccionada
       */
      setState(() {
        moneyTransaction = selectedToEdit.copyWith();
      });
    }
    final MoneyAccountState moneyAccountState =
        BlocProvider.of<MoneyAccountBloc>(context).state;

    return BlocListener<MoneyTransactionBloc, MoneyTransactionState>(
        listener: (context, state) {
          ///select ingredients in state
          switch (state.statusProgress) {
            case GenericRequestStatus.success:
              if (!finished) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          "Transacción ${state.lastMoneyTransaction!.concept} registrado con éxito.")),
                );
                context
                    .read<MoneyAccountBloc>()
                    .add(const ReloadSelectionMoneyAccountToEditEvent());
                Navigator.pop(context, true);
                setState(() {
                  finished = true;
                });
              }
              break;
            case GenericRequestStatus.error:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
              break;
            default:
              return;
          }
        },
        child: MainLayout(
            title: 'Agregar transacción',
            child: SingleChildScrollView(
                child: Column(children: [
              Material(
                elevation: 2,
                child: Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              title: Text(
                                'Cuenta: ${account!.title} \n(${account.accountType == MoneyAccountTypes.cash ? "Efectivo" : account.bank?.toText()})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Saldo: \$${account.balance}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ToggleButtonsApp(
                            listItems: movementOptions,
                            selection: {movement},
                            onChanged: (value, _) {
                              setState(() {
                                print("value: $value, movement: $movement");
                                if ( value != MovementType.transfer && movement != value) {
                                  // reset toAccountUuid
                                  selectedElement = ItemList<MoneyAccount>('', '', MoneyAccount.empty());
                                }
                                movement = value;

                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          MovementType.transfer == movement
                              ? ListSearchSelectorDropDown(
                                  selected: selectedElement,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                        Icons.account_balance_wallet_outlined),
                                    hintText: 'Cuenta destino',
                                    labelText: 'Cuenta destino *',
                                  ),
                                  onSelected: (item) {
                                    print("Account Selection item: ${item.value} <==> ${item.data?.uuid}");
                                    setState(() {
                                      selectedElement = item;
                                    });
                                  },
                                  items: accountList)
                              : const SizedBox.shrink(),
                          const SizedBox(height: 24),
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.add_box_outlined),
                              hintText: 'Concepto de la compra/deposito',
                              helperText: 'Ej: pago totalplay, pañales, etc.',
                              labelText: 'Concepto *',
                            ),
                            initialValue: moneyTransaction.concept,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (String? value) {
                              setState(() {
                                moneyTransaction =
                                    moneyTransaction.copyWith(concept: value!);
                              });
                            },
                            validator: ValidationBuilder(
                                    requiredMessage: 'Este campo es requerido')
                                .required()
                                .build(),
                          ),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.monetization_on_outlined),
                                hintText: 'Monto de la transacción',
                                helperText:
                                    'El mónto puede ser negativo en caso de que sea un pago',
                                labelText: 'Monto *',
                              ),
                              initialValue: moneyTransaction.amount == 0
                                  ? ''
                                  : moneyTransaction.amount.toString(),
                              onSaved: (String? value) {
                                if (value != null &&
                                    value.isNotEmpty &&
                                    value != '0') {
                                  setState(() {
                                    moneyTransaction = moneyTransaction
                                        .copyWith(amount: double.parse(value));
                                  });
                                }
                              },
                              //make price validation
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == '0') {
                                  return 'Este campo es requerido';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Ingrese un monto válido';
                                }
                                double amount = double.parse(value);
                                if (amount < 0) {
                                  return 'El mónto debe ser positivo';
                                }
                                if (
                                (movement == MovementType.withdraw || movement == MovementType.transfer)
                                    && amount > account.balance) {
                                  return 'Saldo insuficiente Balance estimado(${account.balance - amount})';
                                }
                                return null;
                              }),
                          /*  CategoryEdibleSelector(
                            onChange: (value) {
                              setState(() {
                                money_transaction.money_transactionCategory =
                                    value;
                              });
                            },
                          ),*/
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    final String? toAccountUuid = selectedElement?.data?.uuid;
                                    print("On Save toAccountUuid: $toAccountUuid");
                                    if(movement == MovementType.transfer && toAccountUuid == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Seleccione una cuenta destino')));
                                      return;
                                    }
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      if(movement == MovementType.deposit) {
                                        moneyTransaction = moneyTransaction.copyWith(
                                          toAccountUuid: account.uuid,
                                        );
                                      } else if(movement == MovementType.withdraw) {
                                        moneyTransaction = moneyTransaction.copyWith(
                                          fromAccountUuid: account.uuid,
                                        );
                                      } else if(movement == MovementType.transfer) {
                                        moneyTransaction = moneyTransaction.copyWith(
                                          toAccountUuid: toAccountUuid!,
                                          fromAccountUuid: account.uuid,
                                        );
                                      }

                                      if (moneyTransaction.uuid != null) {
                                        /* context.read<MoneyTransactionBloc>().add(
                                          UpdateMoneyTransactionEvent(
                                                moneyTransaction)); */
                                      } else {
                                        context
                                            .read<MoneyTransactionBloc>()
                                            .add(CreateMoneyTransactionEvent(
                                                transaction: moneyTransaction));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Algunos campos son requeridos')));
                                    }
                                  },
                                  child: const Text('Guardar',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              )
            ]))));
  }
}

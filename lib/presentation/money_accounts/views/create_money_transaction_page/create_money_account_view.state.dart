import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/values/account_types.dart';
import 'package:accountant_manager/domain/values/banks.dart';
import 'package:accountant_manager/domain/values/generic_request_status.dart';
import 'package:accountant_manager/presentation/commons/interfaces/item_list.dart';
import 'package:accountant_manager/presentation/commons/list_search_selector_dropdown.dart';
import 'package:accountant_manager/presentation/commons/list_search_selector_view.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/clear_selection_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/create_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_state.dart';
import 'package:accountant_manager/presentation/money_accounts/views/create_money_transaction_page/create_money_account_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:accountant_manager/presentation/Layouts/MainLayout/main_layout.dart';

class CreateMoneyAccountPageState extends State<CreateMoneyAccountPage> {
  bool finished = false;
  final _formKey = GlobalKey<FormState>();

  MoneyAccount moneyAccount = const MoneyAccount(
    balance: 0,
    accountType: MoneyAccountTypes.cash,
  );
  bool submited = false;

  @override
  void initState() {
    BlocProvider.of<MoneyAccountBloc>(context)
        .add(const ClearSelectionMoneyAccountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //select ingredients of the ingredientBloc
    final selectedToEdit =
        context.select((MoneyAccountBloc bloc) => bloc.state.selectedToEdit);
    ItemList<Banks>? selectedBank;
    ItemList<MoneyAccountTypes>? selectedAccountType;
    if (selectedToEdit != null && moneyAccount.uuid != selectedToEdit.uuid) {
      /**
       * Sincronizar transacción de vista con el del estado del bloc
       * cuando cambia la transacción seleccionada
       */
      setState(() {
        moneyAccount = selectedToEdit.copyWith();
        if(moneyAccount.bank != null){
          selectedBank = ItemList(moneyAccount.bank!.toText(), moneyAccount.bank!.name, moneyAccount.bank!);
        }
        selectedAccountType = ItemList(moneyAccount.accountType.toText(), moneyAccount.accountType.name,moneyAccount.accountType);
              print("moneyAccount bank: ${moneyAccount.bank}");
      });
    }

    return BlocListener<MoneyAccountBloc, MoneyAccountState>(
        listener: (context, state) {
          ///select ingredients in state
          switch (state.statusProgress) {
            case GenericRequestStatus.success:
              if (!finished) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          "Transacción ${state.lastMoneyAccount!.title} registrado con éxito.")),
                );

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
            title: 'Nueva cuenta',
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
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.abc_outlined),
                              hintText: 'Título de la cuenta',
                              helperText: 'Ej: Nómina, Simplicity, 2.0, etc.',
                              labelText: 'Título *',
                            ),
                            initialValue: moneyAccount.title,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (String? value) {
                              setState(() {
                                moneyAccount =
                                    moneyAccount.copyWith(title: value!);
                              });
                            },
                            validator: ValidationBuilder(
                                    requiredMessage: 'Este campo es requerido')
                                .required()
                                .build(),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.numbers),
                              hintText: 'XXXX-XXXX-XXXX-XXXX',
                              helperText: 'Ej: Número de cuenta o tarjeta.',
                              labelText: 'Número de cuenta *',
                            ),
                            initialValue: moneyAccount.accountNumber,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onSaved: (String? value) {
                              setState(() {
                                moneyAccount =
                                    moneyAccount.copyWith(accountNumber: value!);
                              });
                            },
                            validator: ValidationBuilder(
                                requiredMessage: 'Este campo es requerido')
                                .required()
                                .build(),
                          ),
                          const SizedBox(height: 8),
                          ListSearchSelectorDropDown<MoneyAccountTypes>(
                            selected: selectedAccountType,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.switch_account),
                              hintText: 'Seleccione un tipo de cuenta',
                              labelText: 'Tipo de cuenta *',
                            ),
                            items: MoneyAccountTypes.values
                                .map((e) => ItemList(e.toText(), e.name, e))
                                .toList(),
                            onSelected: (option) {
                              setState(() {
                                moneyAccount =
                                    moneyAccount.copyWith(accountType: option.data);
                              });
                            },
                          ),
                          const SizedBox(height: 8),
                          ListSearchSelectorDropDown<Banks>(
                            selected: selectedBank,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.account_balance),
                              hintText: 'Selecciona un banco',
                              labelText: 'Banco *',
                            ),
                            items: Banks.values
                                .map((e) => ItemList(e.toText(), e.name, e))
                                .toList(),
                            onSelected: (bank) {
                              setState(() {
                                moneyAccount =
                                    moneyAccount.copyWith(bank: bank.data);
                                print("moneyAccount bank: ${moneyAccount.bank}");
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      if (moneyAccount.uuid != null) {
                                        /* context.read<MoneyAccountBloc>().add(
                                          UpdateMoneyAccountEvent(
                                                moneyTransaction)); */
                                      } else {
                                        context.read<MoneyAccountBloc>().add(
                                            CreateMoneyAccountEvent(
                                                account: moneyAccount));
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

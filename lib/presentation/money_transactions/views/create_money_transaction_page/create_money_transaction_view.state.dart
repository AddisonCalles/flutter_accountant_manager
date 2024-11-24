import 'package:accountant_manager/domain/values/generic_request_status.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';
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

class CreateMoneyTransactionPageState extends State<CreateMoneyTransactionPage> {
  bool finished = false;
  final _formKey = GlobalKey<FormState>();
  MoneyTransaction moneyTransaction = const MoneyTransaction(
    uuid: 'uuid',
    fromAccountUuid: 'null',
    amount: 0,
    status: MoneyTransactionStatus.pending,
    concept: '',
  );
  bool submited = false;

  @override
  void initState() {
    BlocProvider.of<MoneyTransactionBloc>(context)
        .add(const ClearSelectionMoneyTransactionEvent());
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
            title: 'Nuevo Producto',
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
                                helperText: 'El mónto puede ser negativo en caso de que sea un pago',
                                labelText: 'Monto *',
                              ),
                              initialValue: moneyTransaction.amount  == 0? '': moneyTransaction.amount.toString(),
                              onSaved: (String? value) {
                                if (value != null && value.isNotEmpty && value != '0') {
                                  setState(() {
                                    moneyTransaction = moneyTransaction
                                        .copyWith(amount: double.parse(value));
                                  });
                                }
                              },
                              //make price validation
                              validator: (value) {
                                if (value == null || value.isEmpty || value == '0') {
                                  return 'Este campo es requerido';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Ingrese un monto válido';
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
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      if (moneyTransaction.uuid != null) {
                                        /* context.read<MoneyTransactionBloc>().add(
                                          UpdateMoneyTransactionEvent(
                                                moneyTransaction)); */
                                      } else {
                                        context
                                            .read<MoneyTransactionBloc>()
                                            .add(CreateMoneyTransactionEvent(
                                                account: moneyTransaction));
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

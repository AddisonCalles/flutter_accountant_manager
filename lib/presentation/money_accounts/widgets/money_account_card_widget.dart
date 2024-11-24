import 'package:accountant_manager/presentation/money_accounts/bloc/events/select_to_update_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accountant_manager/domain/entities/money_account.dart';

class MoneyAccountCard extends StatelessWidget {
  final MoneyAccount account;
  final Function(MoneyAccount) onEdit;
  final Function(MoneyAccount) onDelete;

  const MoneyAccountCard({
    super.key,
    required this.account,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 8);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  //max width of container
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    "${account.bank?.toText()}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible),
                  ),
                ),
                const Spacer(),
              ],
            ),
            Text(
              'Precio: \$${account.balance}',
              style: const TextStyle(fontSize: 16),
            ),
            gap,
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            /*Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  account.ingredients.length,
                  (index) {
                    final ingredient = account.ingredients[index];
                    return ItemListIngredientChip(
                      ingredient: ingredient,
                    );
                  },
                )),*/
            gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    //Call event to select edit and go to edible/add
                    context
                        .read<MoneyAccountBloc>()
                        .add(SelectToUpdateMoneyAccountEvent(account));
                    Navigator.pushNamed(context, '/money_accounts/add');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => onDelete(account),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

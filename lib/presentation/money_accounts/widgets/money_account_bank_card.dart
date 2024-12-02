


import 'package:flutter/material.dart';
import 'package:accountant_manager/domain/entities/money_account.dart';

class MoneyAccountBankCardWidget extends StatelessWidget {
  final MoneyAccount account;
  final Function(MoneyAccount) onEdit;
  final Function(MoneyAccount) onDelete;

  const MoneyAccountBankCardWidget({
    super.key,
    required this.account,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(account.uuid),
      height: 140 + (account.hasAccountNumber? 17 : 0),
      margin:
      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.blue.shade500, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    account.title.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  Column(
                    children: [
                      const Text(
                        'Balance:',
                        style:  TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$ ${account.balance}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),

                ]),
            Text(
              account.accountNumber ?? "",
              style:  TextStyle(
                color: Colors.white,
                fontSize: account.hasAccountNumber ? 18:0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  account.bank?.toText() ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                //Icon(Icons.ac_unit_sharp)
                Image.asset(
                  'card_types/visa.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

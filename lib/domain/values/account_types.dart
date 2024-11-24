
enum MoneyAccountTypes{
  cash(1),
  debitCard(2),
  creditCard(3);

  final int value;

  const MoneyAccountTypes(this.value);
}
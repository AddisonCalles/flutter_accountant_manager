
enum MoneyAccountTypes{
  unknown(0),
  cash(1),
  debitCard(2),
  creditCard(3);

  final int value;

  const MoneyAccountTypes([this.value = 0]);

  String toText() {
    String text = name;

    /// convert camelCase to Camel Case, e.g. debitCard -> Debit Card
    return text[0].toUpperCase() + text.substring(1).replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}');
  }

}
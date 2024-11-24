enum MoneyTransactionStatus {
  pending(1),
  completed(2),
  cancelled(4);

  final int value;

  const MoneyTransactionStatus(this.value);

  String toText(){
    String text = toString().split(".")[1];
    return text[0].toUpperCase() + text.substring(1);
  }
}

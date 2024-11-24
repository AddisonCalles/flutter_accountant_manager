enum MoneyAccountStatus {
  active(1),
  inactive(2);

  final int value;

  const MoneyAccountStatus(this.value);

  String toText(){
    String text = toString().split(".")[1];
    return text[0].toUpperCase() + text.substring(1);
  }
}

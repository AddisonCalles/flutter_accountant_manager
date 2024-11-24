// make a enum for the banks


enum Banks {
  banamex(1),
  bancomer(2),
  santander(3),
  hsbc(4),
  scotiabank(5),
  banorte(6),
  inbursa(7),
  afirme(8),
  azteca(9),
  mifel(10),
  monex(11),
  vePorMas(12),
  banbajio(13),
  famsa(14),
  banregio(15),
  bbva(16),
  bancoppel(17),
  banjercito(18),
  mercadoPago(19),
  payPal(20),
  nu(21);

  final int value;

  const Banks([this.value = 0]);


  String toText(){
    String text = name;
    //TODO: separate camelcase with spaces
    return text[0].toUpperCase() + text.substring(1);
  }

}
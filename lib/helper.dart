class Helper {
  String unitFormat(String unit, int quantity) {
    String newstring = '$quantity ${unit.toString()}';
    double newquantity = quantity.toDouble();

    if (unit == 'g') {
      if (quantity >= 1000) {
        newstring = (newquantity / 1000).toString() + ' kg';
      } else if (quantity >= 100) {
        newstring = (newquantity / 100).toString() + ' dkg';
      } else {
        newstring = newquantity.toInt().toString() + " g";
      }
    }

    if (unit == 'ml') {
      if (quantity >= 1000) {
        newstring = (newquantity / 1000).toString() + ' l';
      } else if (quantity >= 100) {
        newstring = (newquantity / 100).toString() + ' dl';
      } else {
        newstring = newquantity.toInt().toString() + " ml";
      }
    }
    if (newstring.contains('.0 ')) {
      return newstring.replaceAllMapped('.0', (match) => '');
    } else {
      return newstring;
    }
  }
}

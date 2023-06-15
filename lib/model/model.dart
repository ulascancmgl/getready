import '../style/style.dart';
import 'package:flutter/material.dart';

class MyClass {
  String property1;
  String property2;
  String property3;
  String property4;
  String property5;
  String property6;

  MyClass(this.property1, this.property2, this.property3, this.property4, this.property5, this.property6);
}

List<String> headers = ['Meşe Ağacı\'nın Gölgesi', 'Kod Adı',
  'Ben bir ceviz ağacıyım', 'Swing Dance Club', 'Potato', 'Lemon'];
List<MyClass> data = [
  MyClass('T', 'W', 'Oryantel', 'M', 'A', 'N'),
  MyClass('S', 'U', 'C', 'M', 'A', 'N'),
  MyClass('A', 'N', 'Türkiye\'nin taşına ölürüm', 'M', 'A', 'N'),
  MyClass('B', 'A', 'T', 'M', 'A', 'Neandartallerin korkulu rüyası'),
];

List<Function(MyClass)> propertyGetters = [
      (item) => item.property1,
      (item) => item.property2,
      (item) => item.property3,
      (item) => item.property4,
      (item) => item.property5,
      (item) => item.property6,
];

Widget myTable = AppStyles.tableContainerVertical(headers, data, propertyGetters);
Widget myTable2 = AppStyles.tableContainerHorizontal(headers, data, propertyGetters);

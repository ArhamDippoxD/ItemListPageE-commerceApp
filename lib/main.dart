import'package:flutter/material.dart';
import 'package:ecommerce/itemList.dart';
import 'dart:ffi';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget

{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      home:  ItemListPage(),
    );
  }
}

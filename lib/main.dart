import 'package:flutter/material.dart';
import 'package:preco_bitcoin/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Preço do Bitcoin",
      home: Home(),
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
    );
  }
}

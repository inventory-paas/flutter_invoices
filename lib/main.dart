import 'package:flutter/material.dart';

import 'package:flutter_invoices/views/home.dart';

void main() {
  runApp(const FlutterInvoices());
}

class FlutterInvoices extends StatelessWidget {
  const FlutterInvoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const Home(),
    );
  }
}

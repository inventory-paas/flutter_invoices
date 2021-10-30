import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_invoices/apis/download.dart';
import 'package:flutter_invoices/apis/pdf_invoice_api.dart';
import 'package:flutter_invoices/models/customer.dart';
import 'package:flutter_invoices/models/invoice.dart';
import 'package:flutter_invoices/models/supplier.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final dueDate = date.add(const Duration(days: 7));
    final invoice = Invoice(
      supplier: const Supplier(
        name: 'Sarah Field',
        address: 'Sarah Street 9, Beijing, China',
        paymentInfo: 'https://paypal.me/sarahfieldzz',
      ),
      customer: const Customer(
        name: 'Apple Inc.',
        address: 'Apple Street, Cupertino, CA 95014',
      ),
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: 'My description...',
        number: '${DateTime.now().year}-9999',
      ),
      items: [
        InvoiceItem(
          description: 'Coffee',
          date: DateTime.now(),
          quantity: 3,
          vat: 0.19,
          unitPrice: 5.99,
        ),
        InvoiceItem(
          description: 'Water',
          date: DateTime.now(),
          quantity: 8,
          vat: 0.19,
          unitPrice: 0.99,
        ),
        InvoiceItem(
          description: 'Orange',
          date: DateTime.now(),
          quantity: 3,
          vat: 0.19,
          unitPrice: 2.99,
        ),
        InvoiceItem(
          description: 'Apple',
          date: DateTime.now(),
          quantity: 8,
          vat: 0.19,
          unitPrice: 3.99,
        ),
        InvoiceItem(
          description: 'Mango',
          date: DateTime.now(),
          quantity: 1,
          vat: 0.19,
          unitPrice: 1.59,
        ),
        InvoiceItem(
          description: 'Blue Berries',
          date: DateTime.now(),
          quantity: 5,
          vat: 0.19,
          unitPrice: 0.99,
        ),
        InvoiceItem(
          description: 'Lemon',
          date: DateTime.now(),
          quantity: 4,
          vat: 0.19,
          unitPrice: 1.29,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Invoices')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text("Default"),
            onTap: () async {
              final Uint8List invoicePdf =
                  await PdfInvoiceApi.generate(invoice);
              download(invoicePdf, 'invoicePDF.pdf');
            },
            trailing: const Icon(Icons.download),
          ),
        ],
      ),
    );
  }
}

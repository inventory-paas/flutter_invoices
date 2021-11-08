import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:flutter_invoices/apis/download.dart';
import 'package:flutter_invoices/models/address.dart';
import 'package:flutter_invoices/models/invoice.dart';
import 'package:flutter_invoices/apis/bw_pdf_invoice.dart';
import 'package:flutter_invoices/models/customer_details.dart';
import 'package:flutter_invoices/models/business_details.dart';
import 'package:flutter_invoices/apis/coloured_pdf_invoice.dart';
import 'package:flutter_invoices/models/invoice_info.dart';
import 'package:flutter_invoices/models/invoice_item.dart';
import 'package:flutter_invoices/models/shipping_details.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invoice = Invoice(
      customer: CustomerDetails(
        id: 181001,
        shippingDetails: ShippingDetails(
          phoneNumber: "+919825583377",
          email: "jpratham1809@gmail.com",
          address: Address(
            line1: '19, Shital Nagar, Mankodia',
            line2: 'vijalpor',
            city: 'Navsari',
            postalCode: '396450',
            country: 'India',
            state: 'Gujarat',
          ),
        ),
      ),
      supplier: BusinessDetails(
        name: 'Pr47h4m',
        phoneNumber: '+919825583377',
        email: 'pr47h4m@gmail.com',
        gstNumber: '+919825583377',
        address: Address(
            line1: '19, Shital Nagar, Mankodia',
            line2: 'vijalpor',
            city: 'Navsari',
            postalCode: '396450',
            country: 'India',
            state: 'Gujarat'),
        website: 'https://store.mynshop24.online',
      ),
      info: InvoiceInfo(
        amount: 1000000,
        currency: '\$',
        date: DateTime.now(),
        id: 181001,
        shipmentType: 'delivery',
        status: 'dispatched',
      ),
      items: const [
        InvoiceItem(
          name: 'gold-toned & white floral textured lamp',
          tax: 0,
          discount: 50,
          quantity: 3,
          unitLabel: 'pcs',
          unitPrice: 399900,
        ),
        InvoiceItem(
          name: 'black smartwatch',
          tax: 0,
          discount: 10,
          quantity: 1,
          unitLabel: 'pcs',
          unitPrice: 399900,
        ),
        InvoiceItem(
          name: 'flip 5 portable waterproof speaker (black)',
          tax: 0,
          discount: 0,
          quantity: 2,
          unitLabel: 'pcs',
          unitPrice: 999900,
        ),
        InvoiceItem(
          name: 'men khaki & blue checked casual shirt',
          tax: 0,
          discount: 50,
          quantity: 1,
          unitLabel: 'pcs',
          unitPrice: 74900,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Invoices')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text("Default black and white"),
            onTap: () async {
              final Uint8List invoicePdf =
                  await DefaultPDFInvoice.generate(invoice);
              download(invoicePdf, 'invoicePDF.pdf');
            },
            trailing: const Icon(Icons.download),
          ),
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text("Default coloured"),
            onTap: () async {
              final Uint8List invoicePdf =
                  await ColouredPDFInvoice.generate(invoice);
              download(invoicePdf, 'invoicePDF.pdf');
            },
            trailing: const Icon(Icons.download),
          ),
        ],
      ),
    );
  }
}

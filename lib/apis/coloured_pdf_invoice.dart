import 'dart:typed_data';
import 'package:flutter_invoices/models/invoice_info.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:flutter_invoices/utils/utils.dart';
import 'package:flutter_invoices/models/invoice.dart';
import 'package:flutter_invoices/models/customer_details.dart';
import 'package:flutter_invoices/models/business_details.dart';

class ColouredPDFInvoice {
  static Future<Uint8List> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      pageTheme: const PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(24),
      ),
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 0.6 * PdfPageFormat.cm),
        buildInvoice(invoice),
        SizedBox(height: 0.6 * PdfPageFormat.cm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInvoiceInfo(invoice.info),
            SizedBox(width: 0.8 * PdfPageFormat.cm),
            buildTotal(invoice)
          ],
        ),
        SizedBox(height: 0.6 * PdfPageFormat.cm),
        Divider(color: PdfColors.grey),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return await pdf.save();
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invoice",
            style: TextStyle(
              color: PdfColors.deepPurple400,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invoice#",
                            style: const TextStyle(color: PdfColors.grey),
                          ),
                          SizedBox(height: 0.4 * PdfPageFormat.cm),
                          Text(
                            "Date",
                            style: const TextStyle(color: PdfColors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 0.8 * PdfPageFormat.cm),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1810",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 0.5 * PdfPageFormat.cm),
                          Text(
                            "SEP 18, 2021",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "IPaaS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            children: [
              buildSupplierAddress(invoice.supplier),
              SizedBox(width: 0.8 * PdfPageFormat.cm),
              buildCustomerAddress(invoice.customer),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(CustomerDetails customer) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: PdfColors.deepPurple50,
          ),
          padding: const EdgeInsets.all(
            0.4 * PdfPageFormat.cm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billed to',
                style: const TextStyle(
                  color: PdfColors.deepPurple400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(
                '${customer.id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(customer.shippingDetails.phoneNumber),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(customer.shippingDetails.email),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(customer.shippingDetails.address.toString(), maxLines: 2),
            ],
          ),
        ),
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    return Expanded(
      flex: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Terms & Conditions",
            style: TextStyle(
              color: PdfColors.deepPurple400,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Text(
            "1. Please bring invoice in case of any returns",
            style: const TextStyle(color: PdfColors.grey),
          ),
          SizedBox(height: 0.6 * PdfPageFormat.cm),
          Text(
            "Additional Notes",
            style: TextStyle(
              color: PdfColors.deepPurple400,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Text(
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has more or less normal distribution of letters, as opposed to using content here, content here",
            style: const TextStyle(color: PdfColors.grey),
            maxLines: 4,
          ),
          SizedBox(height: 0.6 * PdfPageFormat.cm),
          Text(
            "For any enquiries. email us on support@ipaas.com or call us on +91 12345 67890",
            style: const TextStyle(color: PdfColors.grey),
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  static Widget buildSupplierAddress(BusinessDetails supplier) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: PdfColors.deepPurple50,
          ),
          padding: const EdgeInsets.all(
            0.4 * PdfPageFormat.cm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billed by',
                style: const TextStyle(
                  color: PdfColors.deepPurple400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(
                supplier.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(supplier.phoneNumber),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(supplier.email),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(supplier.address.toString(), maxLines: 2),
            ],
          ),
        ),
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Item #/Item description',
      'Unit price',
      'Qty.',
      'Tax',
      'Taxable amount',
      'Amount'
    ];
    final data = invoice.items
        .asMap()
        .map((index, item) {
          final total = (item.unitPrice / 100) *
              item.quantity *
              (1 + (item.tax / 100)) *
              (1 - (item.discount / 100));

          return MapEntry(index, [
            '${index + 1}. ${item.name}',
            '\$ ${item.unitPrice / 100}',
            '${item.quantity}',
            '${item.tax} %',
            '\$ ${total.toStringAsFixed(2)}',
            '\$ ${total.toStringAsFixed(2)}',
          ]);
        })
        .values
        .toList();
    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: const TextStyle(
        color: PdfColors.white,
      ),
      cellDecoration: (int a, dynamic b, int c) => BoxDecoration(
        color: c % 2 == 1 ? PdfColors.deepPurple50 : PdfColors.white,
      ),
      headerDecoration: const BoxDecoration(
        color: PdfColors.deepPurple400,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.tax;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;

    return Expanded(
      flex: 4,
      child: Container(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildText(
              title: 'Sub Total',
              value: '\$40,000',
              unite: true,
            ),
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            buildText(
              title: 'Discount (10%)',
              titleStyle: const TextStyle(color: PdfColors.green),
              value: '- \$400',
              unite: true,
            ),
            Divider(color: PdfColors.grey),
            buildText(
              title: 'Total',
              titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              value: Utils.formatPrice(total),
              unite: true,
            ),
            Divider(color: PdfColors.grey),
            Text(
              'Invoice total (in words)',
              style: const TextStyle(color: PdfColors.grey),
            ),
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Text(
              NumberToWord().convert('en-in', 42480),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              buildSimpleText(
                  title: 'Address', value: invoice.supplier.address.toString()),
              if (invoice.supplier.website != null) ...{
                SizedBox(height: 2 * PdfPageFormat.mm),
                buildSimpleText(
                    title: 'Website', value: invoice.supplier.website!),
              },
            ],
          ),
          BarcodeWidget(
            barcode: Barcode.qrCode(),
            data: '${invoice.info.id}',
            height: 48,
            width: 48,
          ),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}

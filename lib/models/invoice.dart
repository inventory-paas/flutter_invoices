import 'package:flutter_invoices/models/invoice_info.dart';
import 'package:flutter_invoices/models/invoice_item.dart';
import 'package:flutter_invoices/models/customer_details.dart';
import 'package:flutter_invoices/models/business_details.dart';

class Invoice {
  final InvoiceInfo info;
  final List<InvoiceItem> items;
  final CustomerDetails customer;
  final BusinessDetails supplier;

  const Invoice({
    required this.info,
    required this.items,
    required this.customer,
    required this.supplier,
  });
}

import 'package:flutter_invoices/models/shipping_details.dart';

class CustomerDetails {
  final int id;
  final ShippingDetails shippingDetails;

  const CustomerDetails({
    required this.id,
    required this.shippingDetails,
  });
}

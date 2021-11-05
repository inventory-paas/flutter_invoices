import 'package:flutter_invoices/models/address.dart';

class ShippingDetails {
  final Address address;
  final String phoneNumber;
  final String email;

  ShippingDetails({
    required this.address,
    required this.email,
    required this.phoneNumber,
  });
}

import 'package:flutter_invoices/models/address.dart';

class BusinessDetails {
  final String name;
  final String phoneNumber;
  final String email;
  final Address address;
  final String? website;
  final String? gstNumber;

  const BusinessDetails({
    required this.phoneNumber,
    required this.email,
    required this.name,
    required this.address,
    this.website,
    this.gstNumber,
  });
}

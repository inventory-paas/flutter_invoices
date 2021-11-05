class BusinessDetails {
  final String name;
  final String address;
  final String? website;
  final String? gstNumber;

  const BusinessDetails({
    required this.name,
    required this.address,
    this.website,
    this.gstNumber,
  });
}

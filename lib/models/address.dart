class Address {
  final String line1;
  final String? line2;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  Address({
    required this.line1,
    this.line2,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  @override
  String toString() {
    return line1 +
        (line2 != null ? ', ' + line2! + '\n' : '\n') +
        city +
        ', ' +
        state +
        ' - ' +
        postalCode +
        ', ' +
        country;
  }
}

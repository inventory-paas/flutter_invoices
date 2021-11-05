class InvoiceInfo {
  final String id;
  final DateTime date;
  final String status;
  final double amount;
  final String currency;
  final String shipmentType;

  const InvoiceInfo({
    required this.id,
    required this.date,
    required this.status,
    required this.amount,
    required this.currency,
    required this.shipmentType,
  });
}

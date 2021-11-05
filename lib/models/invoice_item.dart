class InvoiceItem {
  final String name;
  final String? image;
  final double quantity;
  final double tax;
  final double discount;
  final double unitPrice;
  final String unitLabel;

  const InvoiceItem({
    this.image,
    required this.name,
    required this.tax,
    required this.discount,
    required this.quantity,
    required this.unitLabel,
    required this.unitPrice,
  });
}

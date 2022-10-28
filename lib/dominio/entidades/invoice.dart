import 'customer.dart';
import 'supplier.dart';

class Invoice {
  final String titulo;
  final InvoiceInfo info;
  final Supplier supplier;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.titulo,
    required this.supplier,
    required this.items,
  });
}

class InvoiceInfo {
  final DateTime date;

  const InvoiceInfo({
    required this.date,
  });
}

class InvoiceItem {
  final List<String> itens;

  InvoiceItem(this.itens);
}

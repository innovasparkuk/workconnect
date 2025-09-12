class AppTransaction {
  final String title;
  final String subtitle;
  final DateTime date;
  final double amount;
  final String type; // income/expense/transfer
  final String status; // completed/pending

  AppTransaction({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.type,
    required this.status,
  });
}

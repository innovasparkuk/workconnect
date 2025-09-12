import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../theme.dart';

class TransactionTile extends StatelessWidget {
  final AppTransaction tx;
  const TransactionTile({Key? key, required this.tx}) : super(key: key);

  Color _amountColor() {
    if (tx.type == 'income') return Colors.green;
    if (tx.type == 'expense') return Colors.red;
    return kAccentLight;
  }

  IconData _iconForType() {
    if (tx.type == 'income') return Icons.arrow_downward;
    if (tx.type == 'expense') return Icons.arrow_upward;
    return Icons.sync_alt;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kBackground,
          child: Icon(_iconForType(), color: _amountColor()),
        ),
        title: Text(tx.title, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(tx.subtitle),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((tx.amount >= 0 ? '+' : '') + '\$${tx.amount.toStringAsFixed(2)}', style: TextStyle(color: _amountColor(), fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('${tx.date.month}/${tx.date.day}/${tx.date.year}', style: TextStyle(fontSize: 11, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

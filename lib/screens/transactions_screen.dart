import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import '../models/transaction_model.dart';
import '../widgets/transaction_tile.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<AppTransaction> transactions = [
    AppTransaction(title: 'Payment Received', subtitle: 'Client payment', date: DateTime.now(), amount: 2500, type: 'income', status: 'completed'),
    AppTransaction(title: 'Grocery', subtitle: 'Supermarket', date: DateTime.now().subtract(Duration(days:1)), amount: -120.75, type: 'expense', status: 'completed'),
    AppTransaction(title: 'Transfer', subtitle: 'Savings', date: DateTime.now().subtract(Duration(days:2)), amount: 500, type: 'transfer', status: 'pending'),
  ];

  String filter = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered = transactions.where((t) {
      if (filter == 'All') return true;
      if (filter == 'Income') return t.type == 'income';
      if (filter == 'Expense') return t.type == 'expense';
      if (filter == 'Transfer') return t.type == 'transfer';
      return true;
    }).toList();

    return Scaffold(
      drawer: CustomDrawer(currentRoute: '/transactions'),
      appBar: AppBar(
        title: Text('Transaction History'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // summary top
            Row(
              children: [
                Expanded(child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Total Income', style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 6),
                    Text('\$24,580.00', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ]),
                )),
                SizedBox(width: 10),
                Expanded(child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Total Expenses', style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 6),
                    Text('\$18,240.00', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ]),
                )),
                SizedBox(width: 10),
                Expanded(child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Net Balance', style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 6),
                    Text('\$6,340.00', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ]),
                )),
              ],
            ),

            SizedBox(height: 12),

            // filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Income', 'Expense', 'Transfer', 'Completed', 'Pending'].map((f) {
                  final selected = f == filter;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(label: Text(f), selected: selected, onSelected: (_) {
                      setState(() => filter = f);
                    }),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 12),

            // list
            Expanded(
              child: ListView(
                children: filtered.map((t) => TransactionTile(tx: t)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

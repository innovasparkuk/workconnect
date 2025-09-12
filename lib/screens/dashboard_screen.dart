import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/summary_card.dart';
import '../widgets/line_chart.dart'; // ✅ only keep line chart
import '../models/transaction_model.dart';
import '../widgets/transaction_tile.dart';
import '../theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<AppTransaction> sampleTxs = [
    AppTransaction(
        title: 'Payment Received',
        subtitle: 'Client payment for services',
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: 2500.0,
        type: 'income',
        status: 'completed'),
    AppTransaction(
        title: 'Purchase at Food',
        subtitle: 'Grocery store',
        date: DateTime.now().subtract(const Duration(days: 2)),
        amount: -85.5,
        type: 'expense',
        status: 'completed'),
    AppTransaction(
        title: 'Bank Transfer',
        subtitle: 'To savings',
        date: DateTime.now().subtract(const Duration(days: 3)),
        amount: 1000.0,
        type: 'transfer',
        status: 'pending'),
    AppTransaction(
        title: 'Purchase at Transport',
        subtitle: 'Taxi ride',
        date: DateTime.now().subtract(const Duration(days: 4)),
        amount: -24.75,
        type: 'expense',
        status: 'completed'),
    AppTransaction(
        title: 'Freelance Payment',
        subtitle: 'Website project',
        date: DateTime.now().subtract(const Duration(days: 5)),
        amount: 1200.0,
        type: 'income',
        status: 'completed'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(currentRoute: '/'),
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 6),
            Text('Dashboard', style: TextStyle(color: Colors.black87)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Row(
              children: [
                // ✅ Transactions gradient button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/transactions'),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kAccentLight, kPrimaryLight],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: const Row(
                        children: [
                          Icon(Icons.swap_horiz, color: Colors.white),
                          SizedBox(width: 6),
                          Text('Transactions',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // ✅ Reports gradient button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/reports'),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kPrimaryLight,kAccentLight],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: const Row(
                        children: [
                          Icon(Icons.show_chart, color: Colors.white),
                          SizedBox(width: 6),
                          Text('Reports',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          children: [
            // top tab-like toggle
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.03), blurRadius: 8)
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: const Row(
                children: [
                  Expanded(
                      child: Text('Overview',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600))),
                  Expanded(child: Text('Generate', textAlign: TextAlign.center)),
                  Expanded(child: Text('History', textAlign: TextAlign.center)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Summary Cards Row
            Row(
              children: [
                Expanded(
                    child: SummaryCard(
                        title: 'Total Revenue',
                        value: '\$45,280.00',
                        icon: Icons.attach_money,
                        valueColor: Colors.green)),
                const SizedBox(width: 12),
                Expanded(
                    child: SummaryCard(
                        title: 'Total Expenses',
                        value: '\$28,150.00',
                        icon: Icons.money_off,
                        valueColor: Colors.red)),
                const SizedBox(width: 12),
                Expanded(
                    child: SummaryCard(
                        title: 'Profit Margin',
                        value: '37.8%',
                        icon: Icons.pie_chart_outline,
                        valueColor: kAccentLight)),
              ],
            ),

            const SizedBox(height: 16),

            // Monthly Trends with Line Chart
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Monthly Trends',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SimpleLineChart(
                  values: [2000, 4000, 10000, 8000, 7000, 6000, 10000, 5000, 9000, 7000, 6000, 4000],
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Generate New Report UI (simplified)
            Card(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Generate New Report',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: [
                        'Daily',
                        'Weekly',
                        'Monthly',
                        'Yearly',
                        'Custom'
                      ].map((label) {
                        return ChoiceChip(
                            label: Text(label),
                            selected: label == 'Daily',
                            onSelected: (_) {});
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        'Revenue',
                        'Expenses',
                        'Profit',
                        'Users',
                        'Orders'
                      ].map((label) {
                        return FilterChip(
                            label: Text(label),
                            selected: label == 'Revenue',
                            onSelected: (_) {});
                      }).toList(),
                    ),
                    const SizedBox(height: 12),

                    // ✅ Gradient Generate Report button
                    // ✅ Gradient Generate Report button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to Reports & Analytics page
                        Navigator.pushNamed(context, '/reports');
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xD0267685), // deepPurple
                              Color(0xFF178E76), // teal-like accent
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.insert_drive_file_rounded, color: Colors.white),
                              SizedBox(width: 6),
                              Text('Generate Report',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Recent Transactions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recent Transactions',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                ...sampleTxs.map((t) => TransactionTile(tx: t)).toList(),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

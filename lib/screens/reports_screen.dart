import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/line_chart.dart';
import '../widgets/summary_card.dart';
import '../theme.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String _selectedPeriod = 'Daily';
  String _selectedCategory = 'Revenue';

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(currentRoute: '/reports'),
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Generate'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ----------------- OVERVIEW -----------------
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
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
                const Text('Monthly Trends',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                const SimpleLineChart(
                  values: [8000, 12000, 9000, 15000, 11000, 16000],
                ),
              ],
            ),
          ),

          // ----------------- GENERATE -----------------
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Generate New Report',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Daily', 'Weekly', 'Monthly', 'Yearly', 'Custom']
                      .map((p) {
                    return ChoiceChip(
                        label: Text(p),
                        selected: _selectedPeriod == p,
                        onSelected: (_) {
                          setState(() => _selectedPeriod = p);
                        });
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: ['Revenue', 'Expenses', 'Profit', 'Users', 'Orders']
                      .map((c) {
                    return FilterChip(
                        label: Text(c),
                        selected: _selectedCategory == c,
                        onSelected: (_) {
                          setState(() => _selectedCategory = c);
                        });
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.insert_chart),
                    label: const Text('Generate Report')),
                const SizedBox(height: 24),
                const Text('Generated Reports',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.description),
                    title:
                    const Text('Monthly Revenue Report - December'),
                    subtitle: const Text('Generated on 13/12/2024'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.download)),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Weekly Expense Analysis'),
                    subtitle: const Text('Generated on 15/12/2024'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.download)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ----------------- HISTORY -----------------
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('Report History',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.insert_drive_file),
                    title: const Text('Q1 Profit Analysis'),
                    subtitle: const Text('10/10/2024'),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.download)),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.insert_drive_file),
                    title: const Text('Monthly Revenue - Jan'),
                    subtitle: const Text('05/01/2025'),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

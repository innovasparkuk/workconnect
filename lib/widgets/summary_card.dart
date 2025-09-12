import 'package:flutter/material.dart';
import '../theme.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [kAccentLight, kPrimaryLight]),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: kPrimaryLight.withOpacity(0.12), blurRadius: 8, offset: Offset(0,4))],
              ),
              padding: EdgeInsets.all(12),
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 6),
                  Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: valueColor ?? Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

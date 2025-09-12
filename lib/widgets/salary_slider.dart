import 'package:flutter/material.dart';

class SalarySlider extends StatelessWidget {
  final double value;
  final void Function(double) onChanged;

  const SalarySlider({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Expected Salary', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('\$20K'),
              Expanded(
                child: Slider(
                  value: value,
                  min: 20000,
                  max: 200000,
                  divisions: 18,
                  label: '\$${value.toInt()}',
                  onChanged: onChanged,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF2BB673),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${value.toInt()}',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FilterChipGroup<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T? selected;
  final void Function(T) onSelected;

  const FilterChipGroup({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded( // 👈 makes each dropdown share row space
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6), // spacing between dropdowns
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: selected,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
            hint: Text(label),
            items: options
                .map(
                  (e) => DropdownMenuItem(
                value: e,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    e.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            )
                .toList(),
            onChanged: (val) {
              if (val != null) onSelected(val);
            },
          ),
        ),
      ),
    );
  }
}

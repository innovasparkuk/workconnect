import 'package:flutter/material.dart';

class SkillInput extends StatefulWidget {
  final List<String> skills;
  final void Function(String) onAdd;
  final VoidCallback onUploadCV;

  const SkillInput({
    super.key,
    required this.skills,
    required this.onAdd,
    required this.onUploadCV,
  });

  @override
  State<SkillInput> createState() => _SkillInputState();
}

class _SkillInputState extends State<SkillInput> {
  final controller = TextEditingController();

  void _addSkill() {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      widget.onAdd(text);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Add skill",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _addSkill,
              icon: const Icon(Icons.add_circle, color: Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          children: widget.skills.map((s) => Chip(label: Text(s))).toList(),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: widget.onUploadCV,
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload CV"),
        ),
      ],
    );
  }
}

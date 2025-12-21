import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/gradient_app_bar.dart';

class CreateJobScreen extends StatefulWidget {
  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  String _selectedCategory = 'web';
  String _selectedPriority = 'medium';
  List<String> _selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: GradientAppBar(
        title: "Create New Job",
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: _saveDraft,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Job Title
              _buildTextField(
                controller: _titleController,
                label: "Job Title",
                hint: "Enter job title...",
                icon: Icons.work_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Job Description
              _buildTextArea(
                controller: _descriptionController,
                label: "Job Description",
                hint: "Describe the job requirements...",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job description';
                  }
                  if (value.length < 50) {
                    return 'Description should be at least 50 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Category & Priority
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: "Category",
                      value: _selectedCategory,
                      items: [
                        DropdownMenuItem(value: 'web', child: Text('Web Development')),
                        DropdownMenuItem(value: 'mobile', child: Text('Mobile App')),
                        DropdownMenuItem(value: 'design', child: Text('UI/UX Design')),
                        DropdownMenuItem(value: 'content', child: Text('Content Writing')),
                        DropdownMenuItem(value: 'marketing', child: Text('Digital Marketing')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: "Priority",
                      value: _selectedPriority,
                      items: [
                        DropdownMenuItem(value: 'low', child: Text('Low Priority')),
                        DropdownMenuItem(value: 'medium', child: Text('Medium Priority')),
                        DropdownMenuItem(value: 'high', child: Text('High Priority')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Budget & Deadline
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _budgetController,
                      label: "Budget",
                      hint: "\$0.00",
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter budget';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _deadlineController,
                      label: "Deadline",
                      hint: "DD/MM/YYYY",
                      icon: Icons.calendar_today,
                      onTap: () => _selectDeadline(context),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select deadline';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Skills Required
              _buildSkillsSection(),
              SizedBox(height: 24),

              // Submit Button
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onTap: onTap,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primaryGreen),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.cardWhite,
        ),
      ),
    );
  }

  Widget _buildTextArea({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.cardWhite,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Skills Required",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _buildSkillChips(),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _addSkill,
              icon: Icon(Icons.add, size: 18),
              label: Text("Add Skill"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen.withOpacity(0.1),
                foregroundColor: AppColors.primaryGreen,
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSkillChips() {
    return _selectedSkills.map((skill) => Chip(
      label: Text(skill),
      deleteIcon: Icon(Icons.close, size: 16),
      onDeleted: () {
        setState(() {
          _selectedSkills.remove(skill);
        });
      },
      backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
    )).toList();
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitJob,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_circle_outline),
          SizedBox(width: 8),
          Text(
            "Create Job",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _deadlineController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _addSkill() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Skill"),
        content: TextField(
          decoration: InputDecoration(
            hintText: "Enter skill...",
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty && !_selectedSkills.contains(value)) {
              setState(() {
                _selectedSkills.add(value);
              });
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final skill = (context as Element).findAncestorStateOfType<_CreateJobScreenState>()?._getCurrentSkill();
              if (skill != null && skill.isNotEmpty && !_selectedSkills.contains(skill)) {
                setState(() {
                  _selectedSkills.add(skill);
                });
              }
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  String? _getCurrentSkill() {
    // This would typically get the current skill from the dialog
    return "New Skill";
  }

  void _submitJob() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with job creation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Job created successfully!"),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    }
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Draft saved successfully!"),
        backgroundColor: AppColors.info,
      ),
    );
  }
}
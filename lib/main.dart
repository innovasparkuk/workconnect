import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';
import 'widgets/category_tile.dart';
import 'widgets/salary_slider.dart';
import 'widgets/custom_button.dart';
import 'widgets/filter_chip_group.dart';
// import 'widgets/skill_input.dart'; // not needed now

void main() {
  runApp(const JobConnectApp());
}

class JobConnectApp extends StatelessWidget {
  const JobConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const JobConnectPage(),
    );
  }
}

class JobConnectPage extends StatefulWidget {
  const JobConnectPage({super.key});

  @override
  State<JobConnectPage> createState() => _JobConnectPageState();
}

class _JobConnectPageState extends State<JobConnectPage> {
  double salary = 50000;
  final emailController = TextEditingController();
  final skillController = TextEditingController();
  final skills = <String>[];
  bool cvUploaded = false;

  // Dropdown selections
  String? experience = 'Entry Level';
  String? education = "Bachelor's";
  String? location = 'Remote';
  String? duration = '3–6 months';
  String? type = 'Full Time';

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Your request for job submitted successfully")),
    );
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft saved, you can use later")),
    );
  }

  void _addSkill() {
    final val = skillController.text.trim();
    if (val.isNotEmpty) {
      setState(() {
        skills.add(val);
        skillController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Skill '$val' added")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.blue, Colors.green], // gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: const Text(
            "JobConnect",
            style: TextStyle(
              fontSize: 28, // 👈 large text
              fontWeight: FontWeight.bold,
              color: Colors.white, // required for ShaderMask
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Tiles
            Row(
              children: [
                CategoryTile(
                  title: "Creative",
                  icon: Icons.campaign,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEDC9F6), Color(0xFFE6BDF6)],
                  ),
                  onTap: () {},
                ),
                CategoryTile(
                  title: "Trending",
                  icon: Icons.trending_up,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD6BF), Color(0xFFEFC7B3)],
                  ),
                  onTap: () {},
                ),
                CategoryTile(
                  title: "Popular",
                  icon: Icons.star,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF64FFDA), Color(0xFF18A192)],
                  ),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search jobs...",
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                filled: true,
                fillColor: Colors.white, // white background
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1), // gray border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5), // blue on focus
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Dropdown filters
            Column(
              children: [
                Row(
                  children: [
                    FilterChipGroup<String>(
                      label: "Experience",
                      options: const ["Entry Level", "Mid Level", "Senior"],
                      selected: experience,
                      onSelected: (val) => setState(() => experience = val),
                    ),
                    FilterChipGroup<String>(
                      label: "Education",
                      options: const ["Bachelor's", "Master's", "PhD"],
                      selected: education,
                      onSelected: (val) => setState(() => education = val),
                    ),
                    FilterChipGroup<String>(
                      label: "Location",
                      options: const ["Remote", "Onsite"],
                      selected: location,
                      onSelected: (val) => setState(() => location = val),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FilterChipGroup<String>(
                      label: "Duration",
                      options: const ["0–3 months", "3–6 months", "6+ months"],
                      selected: duration,
                      onSelected: (val) => setState(() => duration = val),
                    ),
                    FilterChipGroup<String>(
                      label: "Type",
                      options: const ["Full Time", "Part Time", "Contract"],
                      selected: type,
                      onSelected: (val) => setState(() => type = val),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Email + Skill Row + Gradient Button
            Row(
              children: [
                // Email Field
                Expanded(
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter email",
                      prefixIcon: const Icon(Icons.email, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                      ),
                    ),
                  ),

                ),
                const SizedBox(width: 12),

                // Skill Field + Gradient Button
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child:TextField(
                          controller: skillController,
                          decoration: InputDecoration(
                            hintText: "Add skill",
                            prefixIcon: const Icon(Icons.build, color: Colors.green),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                            ),
                          ),
                          onSubmitted: (_) => _addSkill(),
                        ),

                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _addSkill,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF2196F3), // Blue
                                Color(0xFF087764), // Purple
                              ],
                            ),

                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Skills Chips Section
            Wrap(
              spacing: 8,
              children: skills
                  .map((skill) => Chip(
                label: Text(skill),
                backgroundColor: Colors.blue.shade50,
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () {
                  setState(() => skills.remove(skill));
                },
              ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Salary Slider
            SalarySlider(
              value: salary,
              onChanged: (val) => setState(() => salary = val),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120, // 👈 adjust width
                  child: CustomButton(label: "Save Draft", onPressed: _saveDraft),
                ),
                 SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: CustomButton(label: "Submit", isPrimary: true, onPressed: _submit),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

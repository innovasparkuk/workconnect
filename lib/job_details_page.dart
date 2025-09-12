import 'package:flutter/material.dart';

class JobDetailsPage extends StatelessWidget {
  final String title;
  final String company;
  final String salary;
  final String location;

  const JobDetailsPage({
    super.key,
    required this.title,
    required this.company,
    required this.salary,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Gradient AppBar
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        foregroundColor: Colors.white,
        elevation: 4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Job Info Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Icon(Icons.work,
                              color: Colors.blueAccent, size: 30),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(title,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    infoRow(Icons.business, "Company", company),
                    const SizedBox(height: 10),
                    infoRow(Icons.attach_money, "Salary", salary),
                    const SizedBox(height: 10),
                    infoRow(Icons.location_on, "Location", location),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Job Description
            const Text(
              "Job Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  "This is a sample job description. Here you can write details about "
                      "the role, required skills, and responsibilities. The applicant "
                      "will get a chance to work with a dynamic team and grow professionally.",
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 80), // space for bottom button
          ],
        ),
      ),

      // 🔹 Persistent Apply Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Applied Successfully ✅")),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("Apply Now",
              style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }

  // 🔹 Reusable Info Row
  Widget infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 22),
        const SizedBox(width: 10),
        Text("$label: ",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontSize: 16, color: Colors.black54)),
        ),
      ],
    );
  }
}

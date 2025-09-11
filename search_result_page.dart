import 'package:flutter/material.dart';
import 'package:myprojects/job_details_page.dart';

class SearchResultsPage extends StatelessWidget {
  final String query;
  final String category;
  final String minSalary;
  final String maxSalary;
  final bool remoteOnly;

  const SearchResultsPage({
    super.key,
    required this.query,
    required this.category,
    required this.minSalary,
    required this.maxSalary,
    required this.remoteOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text(
          "Search Results",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Search summary box
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.lightBlue, width: 1),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🔍 Results for: $query",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    children: [
                      chip("Category: $category"),
                      chip("Min: $minSalary"),
                      chip("Max: $maxSalary"),
                      chip("Remote: $remoteOnly"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Jobs list
            Expanded(
              child: ListView(
                children: [
                  jobCard(context, "Flutter Developer", "TechSoft Pvt Ltd",
                      "\$2000 - \$4000", "Remote"),
                  jobCard(context, "UI/UX Designer", "Designify Ltd",
                      "\$1500 - \$2500", "On-site"),
                  jobCard(context, "Backend Engineer", "CloudWare",
                      "\$2500 - \$5000", "Remote"),
                  jobCard(context, "Mobile App Developer", "AppX Solutions",
                      "\$1800 - \$3500", "On-site"),
                  jobCard(context, "Project Manager", "Innovatech",
                      "\$3000 - \$6000", "Remote"),
                ],
              ),
            ),
          ],
        ),
      ),

      // 🔹 Floating Action Button for Filters
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Filter options coming soon...")),
          );
        },
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.filter_list),
        label: const Text("Filters"),
      ),
    );
  }

  // 🔹 Job Card Widget
  Widget jobCard(BuildContext context, String title, String company,
      String salary, String location) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.lightBlue.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailsPage(
                title: title,
                company: company,
                salary: salary,
                location: location,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.work, color: Colors.lightBlue, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black)),
                  const SizedBox(height: 6),
                  Text(company,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black54)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      chip(salary),
                      chip(location),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  // 🔹 Chip builder
  Widget chip(String text) {
    return Chip(
      label: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black)),
      backgroundColor: Colors.lightBlue.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.lightBlue, width: 1),
      ),
    );
  }
}

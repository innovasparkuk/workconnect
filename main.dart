import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:myprojects/search_result_page.dart';

void main() {
  runApp(const JobSearchApp());
}

class JobSearchApp extends StatelessWidget {
  const JobSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Search',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const JobSearchPage(),
    );
  }
}

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({super.key});

  @override
  State<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController minSalaryController = TextEditingController();
  final TextEditingController maxSalaryController = TextEditingController();

  String selectedCategory = "All";
  bool remoteOnly = false;

  final List<String> categories = [
    "All",
    "Part-time",
    "Full-time",
    "On-site",
    "Remote",
  ];

  static const String OPENAI_API_KEY = "YOUR_OPENAI_API_KEY_HERE";
  late final OpenAIService _openAIService =
  OpenAIService(apiKey: OPENAI_API_KEY);

  void resetFilters() {
    setState(() {
      searchController.clear();
      minSalaryController.clear();
      maxSalaryController.clear();
      selectedCategory = "All";
      remoteOnly = false;
    });
  }

  void searchJobs() {
    String searchQuery = searchController.text;
    String minSalary = minSalaryController.text;
    String maxSalary = maxSalaryController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(
          query: searchQuery,
          category: selectedCategory,
          minSalary: minSalary,
          maxSalary: maxSalary,
          remoteOnly: remoteOnly,
        ),
      ),
    );
  }

  Future<void> openAutoProposalSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AutoProposalSheet(openAIService: _openAIService),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Full-width Hero Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3A7BD5), Color(0xFF3A6073)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Find Your Dream Job",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Explore thousands of opportunities worldwide",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Floating Search Box
            Transform.translate(
              offset: const Offset(0, -25),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(20),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search jobs (e.g. Flutter Developer)",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                children: categories.map((cat) {
                  final selected = selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() => selectedCategory = cat),
                    selectedColor: Colors.indigo.shade100,
                    labelStyle: TextStyle(
                      color: selected ? Colors.lightBlue : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Salary Inputs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minSalaryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Min Salary \$",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: maxSalaryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Max Salary \$",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Remote Switch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SwitchListTile(
                value: remoteOnly,
                onChanged: (v) => setState(() => remoteOnly = v),
                title: const Text(
                  "Remote only",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Buttons Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: resetFilters,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reset"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: searchJobs,
                      icon: const Icon(Icons.search),
                      label: const Text("Search"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 AI Proposal Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: openAutoProposalSheet,
                icon: const Icon(Icons.description_outlined),
                label: const Text("AI Auto Proposal"),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(500, 50),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),

                  ),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// --------------------------
// Auto Proposal Bottom Sheet
// --------------------------
class AutoProposalSheet extends StatefulWidget {
  final OpenAIService openAIService;
  const AutoProposalSheet({super.key, required this.openAIService});

  @override
  State<AutoProposalSheet> createState() => _AutoProposalSheetState();
}

class _AutoProposalSheetState extends State<AutoProposalSheet> {
  final TextEditingController descController = TextEditingController();
  String result = '';
  bool loading = false;

  Future<void> generate() async {
    if (descController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter job description/skills")),
      );
      return;
    }

    setState(() {
      loading = true;
      result = '';
    });

    try {
      final proposal =
      await widget.openAIService.generateProposal(descController.text);
      setState(() => result = proposal);
    } catch (e) {
      setState(() => result = "Error: ${e.toString()}");
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: ListView(
          controller: controller,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "AI Proposal Generator",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Paste job description or your skills here...",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16)),
                filled: true,
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: loading ? null : generate,
              icon: loading
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.auto_fix_high),
              label: Text(loading ? "Generating..." : "Generate Proposal"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 14),
            if (result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SelectableText(result),
              ),
            if (result.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: result));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Copied to clipboard")),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text("Copy"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// --------------------------
// OpenAI Service
// --------------------------
class OpenAIService {
  final String apiKey;
  OpenAIService({required this.apiKey});

  Future<String> generateProposal(String jobDescription) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content":
          "You are a professional proposal writer. Write a short, concise job proposal in 3 paragraphs."
        },
        {
          "role": "user",
          "content":
          "Create a professional job proposal based on this job description: $jobDescription"
        }
      ],
      "max_tokens": 300,
      "temperature": 0.5,
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"].trim();
    } else {
      throw Exception("Failed: ${response.body}");
    }
  }
}

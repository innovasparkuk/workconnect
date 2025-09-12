import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Hire & Contract'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Custom input decoration for all fields
  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade300,
        titleSpacing: 0,
        foregroundColor: Colors.white,
        title: const Text(
          "Hire & Contract",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage:
                      AssetImage("assets/images/freelancer.jpg"),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "John Dew",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Flutter Developer",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 19),
                            Icon(Icons.star, color: Colors.amber, size: 19),
                            Icon(Icons.star, color: Colors.amber, size: 19),
                            Icon(Icons.star, color: Colors.amber, size: 19),
                            Icon(Icons.star_half,
                                color: Colors.amber, size: 19),
                            SizedBox(width: 4),
                            Text(
                              "4.9",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),

                // Description
                const Text(
                  "Experienced Flutter developer with expertise "
                      "in building modern cross-platform apps.",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                // Job Title
                TextField(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: customInputDecoration("Job Title"),
                ),
                const SizedBox(height: 18),

                // Description
                TextField(
                  maxLines: 2,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: customInputDecoration("Description"),
                ),
                const SizedBox(height: 20),

                // Perfect Time Text
                const Text(
                  "Perfect Time",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Fixed Price & Hourly Row
                Row(
                  children: const [
                    Icon(Icons.monetization_on,
                        color: Color(0xFF66B2FF), size: 30),
                    SizedBox(width: 6),
                    Text(
                      "Fixed Price",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 50),
                    Icon(Icons.access_time,
                        color: Color(0xFF66B2FF), size: 30),
                    SizedBox(width: 6),
                    Text(
                      "Hourly",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Budget & Deadline
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style:
                        const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: customInputDecoration("Budget"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        style:
                        const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: customInputDecoration("Deadline"),
                        items: const [
                          DropdownMenuItem(
                              value: "7", child: Text("7 Days")),
                          DropdownMenuItem(
                              value: "15", child: Text("15 Days")),
                          DropdownMenuItem(
                              value: "30", child: Text("30 Days")),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Terms & Conditions
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(
                      "I agree to the terms & conditions",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Auto Generated Portfolio Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF66B2FF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Auto generated portfolio",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Hire Freelancer Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF66B2FF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Hire Freelancer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


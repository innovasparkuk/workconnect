import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ProfileSetupApp());
}

class ProfileSetupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Professional Profile Setup',
      theme: ThemeData(
        primaryColor: Color(0xFF0066FF),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF0066FF),
          secondary: Color(0xFF7B68EE),
        ),
        scaffoldBackgroundColor: Color(0xFFF8FAFD),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF0066FF), width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      home: ProfileSetupScreen(),
    );
  }
}

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  // Form data
  String _fullName = '';
  String _jobTitle = '';
  String _bio = '';
  String _email = '';
  List<String> _skills = [];
  String _newSkill = '';
  List<PortfolioItem> _portfolioItems = [];
  bool _autoGenerateProfile = true;
  bool _isGeneratingProfile = true;
  final TextEditingController _skillSearchController = TextEditingController();


  late TextEditingController _jobTitleController;
  late TextEditingController _bioController;

  final String _ai21ApiUrl = "https://api.ai21.com/studio/v1/j2-lite/completions";
  final String _ai21ApiKey = "f96a39fb-45cc-4578-8f80-a5ad7c310f2a"; // <-- apna key daalo

  final List<String> _availableSkills = [
    'Flutter', 'Dart', 'React', 'JavaScript', 'Python', 'Java',
    'Kotlin', 'Swift', 'UI/UX Design', 'Data Analysis', 'Firebase',
    'AWS', 'Node.js', 'React Native', 'Git', 'REST APIs', 'GraphQL',
    'SQL', 'MongoDB', 'DevOps', 'Machine Learning', 'Agile Methodology',
    'Problem Solving', 'Team Leadership', 'Project Management'
  ];


  final Map<String, String> _skillDescriptions = {
    'Flutter': 'Building cross-platform mobile apps using Flutter and Dart.',
    'Dart': 'Proficient in Dart programming for scalable apps.',
    'React': 'Experienced in creating responsive web apps using React.',
    'JavaScript': 'Strong command of modern JavaScript and frameworks.',
    'Python': 'Skilled in Python for automation, AI, and data analysis.',
    'Java': 'Expert in Java for backend systems and Android apps.',
    'Kotlin': 'Building modern Android applications with Kotlin.',
    'Swift': 'Developing iOS apps using Swift and SwiftUI.',
    'UI/UX Design': 'Designing user-friendly and engaging app interfaces.',
    'Data Analysis': 'Analyzing and visualizing data for decision making.',
    'Firebase': 'Integrating Firebase for authentication and real-time data.',
    'AWS': 'Deploying scalable apps using AWS cloud services.',
    'Node.js': 'Backend development with Node.js and Express.',
    'React Native': 'Building cross-platform apps with React Native.',
    'Git': 'Version control and collaboration using Git and GitHub.',
    'REST APIs': 'Designing and integrating RESTful APIs.',
    'GraphQL': 'Efficient API design and integration with GraphQL.',
    'SQL': 'Database design and queries using SQL.',
    'MongoDB': 'NoSQL database management using MongoDB.',
    'DevOps': 'CI/CD, Docker, and infrastructure automation.',
    'Machine Learning': 'Implementing ML models for predictive solutions.',
    'Agile Methodology': 'Delivering projects using Agile principles.',
    'Problem Solving': 'Creative and logical approach to solving challenges.',
    'Team Leadership': 'Leading and mentoring development teams.',
    'Project Management': 'Managing timelines, tasks, and deliverables.',
  };

  List<String> _filteredSkills = [];

  @override
  void initState() {
    super.initState();
    _jobTitleController = TextEditingController();
    _bioController = TextEditingController();
    _filteredSkills = _availableSkills;
    _skillSearchController.addListener(_filterSkills);
  }

  @override
  void dispose() {
    _skillSearchController.dispose();
    _jobTitleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _filterSkills() {
    final query = _skillSearchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSkills = _availableSkills;
      } else {
        _filteredSkills = _availableSkills
            .where((skill) => skill.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _addSkill(String skill) {
    if (_skills.length >= 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Maximum 15 skills allowed'), backgroundColor: Colors.red),
      );
      return;
    }

    if (!_skills.contains(skill)) {
      setState(() {
        _skills.add(skill);
      });
      _skillSearchController.clear();
    }
  }

  Future<String> _generateBioWithAI21(List<String> skills) async {
    if (skills.isEmpty) return "No skills selected.";

    final prompt =
        "Write a short professional bio (3-4 sentences) for a person skilled in: ${skills.join(', ')}.";

    final body = jsonEncode({
      "prompt": prompt,
      "numResults": 1,
      "maxTokens": 80,
      "temperature": 0.7,
    });

    try {
      final response = await http.post(
        Uri.parse(_ai21ApiUrl),
        headers: {
          "Authorization": "Bearer $_ai21ApiKey",
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final generated = data["completions"]?[0]?["data"]?["text"];
        if (generated == null || generated.trim().isEmpty) {
          return "Could not generate bio.";
        }
        return generated.trim();
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        return "Error generating bio.";
      }
    } catch (e) {
      print("Exception: $e");
      return "Failed to connect to AI service.";
    }
  }


  Future<void> _generateProfileWithFreeAPI() async {
    if (_skills.isEmpty) return;

    setState(() => _isGeneratingProfile = true);

    try {

      Map<String, String> jobTitles = {
        'Flutter': 'Flutter Developer',
        'React': 'React Developer',
        'UI/UX Design': 'UI/UX Designer',
        'Python': 'Python Developer',
        'Data Analysis': 'Data Analyst',
        'JavaScript': 'JavaScript Developer',
        'Java': 'Java Developer',
        'Node.js': 'Node.js Developer',
        'AWS': 'Cloud Engineer',
        'Machine Learning': 'Machine Learning Engineer',
      };

      String primarySkill = _skills.first;
      for (String skill in _skills) {
        if (jobTitles.containsKey(skill)) {
          primarySkill = skill;
          break;
        }
      }
      String jobTitle = jobTitles[primarySkill] ?? "$primarySkill Specialist";


      String bio = await _generateBioWithAI21(_skills);

      setState(() {
        _jobTitle = jobTitle;
        _bio = bio;
        _jobTitleController.text = jobTitle;
        _bioController.text = bio;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile generated successfully!"), backgroundColor: Colors.green),
      );
    } finally {
      setState(() => _isGeneratingProfile = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Profile'),
        leading: _currentStep > 0
            ? IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            }
          },
        )
            : null,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
      body: Column(
        children: [

          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / 3,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0066FF)),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(height: 8),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_currentStep != 0) {
                      setState(() {
                        _currentStep = 0;
                        _pageController.jumpToPage(0);
                      });
                    }
                  },
                  child: _buildStepLabel('Personal', 0),
                ),
                GestureDetector(
                  onTap: () {
                    if (_currentStep != 1) {
                      setState(() {
                        _currentStep = 1;
                        _pageController.jumpToPage(1);
                      });
                    }
                  },
                  child: _buildStepLabel('Skills', 1),
                ),
                GestureDetector(
                  onTap: () {
                    if (_currentStep != 2) {
                      setState(() {
                        _currentStep = 2;
                        _pageController.jumpToPage(2);
                      });
                    }
                  },
                  child: _buildStepLabel('Portfolio', 2),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Content area
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (page) {
                setState(() {
                  _currentStep = page;
                });
              },
              children: [
                _buildBioStep(),
                _buildSkillsStep(),
                _buildPortfolioStep(),
              ],
            ),
          ),
          // Navigation buttons
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (_currentStep > 0) {
                          setState(() {
                            _currentStep--;
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Back'),
                    ),
                  ),
                if (_currentStep > 0) SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentStep < 2) {
                        if (_currentStep == 0 && _formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }

                        setState(() {
                          _currentStep++;
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                      } else {

                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Process data
                          _showCompletionDialog();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(0xFF0066FF),
                    ),
                    child: Text(
                      _currentStep == 2 ? 'Complete Profile' : 'Next',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepLabel(String text, int step) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: _currentStep == step ? FontWeight.w600 : FontWeight.normal,
            color: _currentStep == step ? Color(0xFF0066FF) : Colors.grey.shade500,
          ),
        ),
        SizedBox(height: 4),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentStep == step ? Color(0xFF0066FF) : Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildBioStep() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 16),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFF0066FF),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) => _fullName = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Job Title',
                prefixIcon: Icon(Icons.work_outline_rounded),
              ),
              controller: _jobTitleController, // ✅ Controller used
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your job title';
                }
                return null;
              },
              onSaved: (value) => _jobTitle = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Bio',
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              ),
              controller: _bioController,
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please tell us about yourself';
                }
                if (value.length < 50) {
                  return 'Please write at least 50 characters';
                }
                return null;
              },
              onSaved: (value) => _bio = value!,
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add your professional skills',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Text(
            'Showcase your expertise by adding relevant skills (max 15)',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          SizedBox(height: 24),

          // Skill search and selection
          Text(
            'Search and select skills:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _skillSearchController,
                    decoration: InputDecoration(
                      hintText: 'Search skills...',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Divider(height: 1),
                Container(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredSkills.length,
                    itemBuilder: (context, index) {
                      final skill = _filteredSkills[index];
                      return ListTile(
                        title: Text(skill),
                        onTap: () => _addSkill(skill),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Or add a custom skill:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Add custom skill',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onChanged: (value) => _newSkill = value,
                ),
              ),
              SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF0066FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    if (_newSkill.isNotEmpty) {
                      _addSkill(_newSkill);
                      _newSkill = '';
                    }
                  },
                  icon: Icon(Icons.add_rounded, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),


          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: _autoGenerateProfile,
                  onChanged: (value) {
                    setState(() {
                      _autoGenerateProfile = value!;
                      if (_autoGenerateProfile && _skills.isNotEmpty) {
                        _generateProfileFromSkills();
                      }
                    });
                  },
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto-generate profile from skills',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Let us create a professional profile based on your skills',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),


          if (_skills.isNotEmpty)
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isGeneratingProfile ? null : _generateProfileWithFreeAPI,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: _isGeneratingProfile
                    ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : Icon(Icons.auto_awesome_rounded),
                label: Text(_isGeneratingProfile ? 'Generating...' : 'Generate Profile with API'),
              ),
            ),
          SizedBox(height: 16),

          // Selected skills chips
          if (_skills.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected skills (${_skills.length}/15):',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _skills.map((skill) {
                    return Chip(
                      label: Text(skill),
                      deleteIcon: Icon(Icons.close_rounded, size: 18),
                      onDeleted: () {
                        setState(() {
                          _skills.remove(skill);
                          if (_autoGenerateProfile) {
                            _generateProfileFromSkills();
                          }
                        });
                      },
                      backgroundColor: Colors.blue.shade50,
                      labelStyle: TextStyle(color: Colors.blue.shade800),
                    );
                  }).toList(),
                ),
              ],
            ),
          if (_skills.isEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(Icons.auto_awesome_rounded, size: 48, color: Colors.grey.shade300),
                  SizedBox(height: 16),
                  Text(
                    'No skills added yet',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: Colors.blue.shade700),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Add your most relevant skills to help others understand your expertise',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPortfolioStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Showcase your work',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Text(
            'Add projects that demonstrate your skills and experience',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () => _addPortfolioItem(),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF0066FF).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add_rounded, color: Color(0xFF0066FF)),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Add portfolio item',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          if (_portfolioItems.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _portfolioItems.length,
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = _portfolioItems[index];
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.work_outline_rounded, color: Color(0xFF0066FF)),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.description,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline_rounded, color: Colors.grey.shade500),
                        onPressed: () {
                          setState(() {
                            _portfolioItems.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          if (_portfolioItems.isEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 40),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(Icons.photo_library_outlined, size: 64, color: Colors.grey.shade300),
                  SizedBox(height: 16),
                  Text(
                    'No portfolio items yet',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add your first project to showcase your work',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  void _generateProfileFromSkills() {
    if (_skills.isEmpty) {
      print('No skills selected for profile generation');
      return;
    }


    Map<String, String> jobTitles = {
      'Flutter': 'Flutter Developer',
      'React': 'React Developer',
      'UI/UX Design': 'UI/UX Designer',
      'Python': 'Python Developer',
      'Data Analysis': 'Data Analyst',
      'JavaScript': 'JavaScript Developer',
      'Java': 'Java Developer',
      'Node.js': 'Node.js Developer',
      'AWS': 'Cloud Engineer',
      'Machine Learning': 'Machine Learning Engineer',
      'Firebase': 'Mobile App Developer',
      'React Native': 'React Native Developer',
      'SQL': 'Database Administrator',
      'MongoDB': 'Database Developer',
      'DevOps': 'DevOps Engineer',
      'Git': 'Version Control Specialist',
    };


    String primarySkill = _skills[0];
    for (String skill in _skills) {
      if (jobTitles.containsKey(skill)) {
        primarySkill = skill;
        break;
      }
    }


    String generatedBio = 'Experienced professional with strong expertise in ';


    if (_skills.length == 1) {
      generatedBio += _skills[0] + '. ';
    } else {
      generatedBio += _skills.sublist(0, _skills.length - 1).join(', ') +
          ' and ' + _skills.last + '. ';
    }


    for (String skill in _skills) {
      if (_skillDescriptions.containsKey(skill)) {
        generatedBio += _skillDescriptions[skill]! + ' ';
      }
    }

    generatedBio += 'Proven track record of delivering high-quality solutions and achieving project objectives.';


    setState(() {
      _jobTitle = jobTitles[primarySkill] ?? '${primarySkill} Professional';
      _bio = generatedBio;


      _jobTitleController.text = _jobTitle;
      _bioController.text = _bio;
    });

    // Success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile automatically generated from your skills!'),
        backgroundColor: Colors.green,
      ),
    );

    print('Auto-generated Job Title: $_jobTitle');
    print('Auto-generated Bio: $_bio');
  }

  void _addPortfolioItem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        String link = '';

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Center(
            child: Container(
            width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Add Portfolio Item',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              labelText: 'Project Title',
            ),
            onChanged: (value) => title = value,
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
            ),
            onChanged: (value) => description = value,
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Link (optional)',
            ),
            onChanged: (value) => link = value,
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Cancel'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (title.isNotEmpty) {
                      setState(() {
                        _portfolioItems.add(
                          PortfolioItem(title, description, link),
                        );
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Add Item'),
                ),
              ),

            ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Profile Complete!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Your professional profile has been successfully set up.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Get Started'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PortfolioItem {
  final String title;
  final String description;
  final String link;

  PortfolioItem(this.title, this.description, this.link);
}
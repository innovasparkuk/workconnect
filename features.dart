import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const FreelanceMarketplace());
}

class FreelanceMarketplace extends StatelessWidget {
  const FreelanceMarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF0066FF),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'Freelance Pro',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: const Color(0xFF0066FF),
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0066FF),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0066FF),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        cardColor: const Color(0xFF2D2D2D),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _darkMode = false;
  String _language = 'English';

  final List<Widget> _screens = [
    const DashboardScreen(),
    const JobsScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  void _toggleDarkMode() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Freelance Pro'),
          backgroundColor: const Color(0xFF0066FF),
          actions: [
            IconButton(
              icon: const Icon(Icons.dark_mode),
              onPressed: _toggleDarkMode,
            ),
            PopupMenuButton<String>(
              onSelected: _changeLanguage,
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(value: 'English', child: Text('English')),
                const PopupMenuItem(value: 'Spanish', child: Text('Spanish')),
                const PopupMenuItem(value: 'French', child: Text('French')),
              ],
            ),
          ],
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: const Color(0xFF0066FF),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Job Recommendations
          _buildSectionTitle('AI Job Recommendations'),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildJobCard(
                  'Mobile App Development',
                  '\$500 - \$1500',
                  '4.9 ★',
                  const Color(0xFF0066FF),
                ),
                _buildJobCard(
                  'UI/UX Design',
                  '\$300 - \$900',
                  '4.8 ★',
                  const Color(0xFF00C853),
                ),
                _buildJobCard(
                  'Web Development',
                  '\$400 - \$1200',
                  '4.7 ★',
                  const Color(0xFFFF6B00),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Skill Tests & Badges
          _buildSectionTitle('Skill Tests & Badges'),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            children: [
              _buildSkillBadge('Flutter', 'Advanced', Icons.code, 85),
              _buildSkillBadge('UI Design', 'Intermediate', Icons.design_services, 70),
              _buildSkillBadge('Backend', 'Expert', Icons.storage, 90),
              _buildSkillBadge('Marketing', 'Beginner', Icons.trending_up, 60),
            ],
          ),

          const SizedBox(height: 24),

          // Subscription Plans
          _buildSectionTitle('Subscription Plans'),
          const SizedBox(height: 16),
          _buildSubscriptionPlans(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A1A1A),
      ),
    );
  }

  Widget _buildJobCard(String title, String price, String rating, Color color) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.work, color: Colors.white, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  rating,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0066FF),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0066FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Apply Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillBadge(String skill, String level, IconData icon, int score) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    score >= 80 ? const Color(0xFF00C853) :
                    score >= 60 ? const Color(0xFF0066FF) :
                    const Color(0xFFFF6B00),
                  ),
                ),
              ),
              Icon(icon, size: 24, color: const Color(0xFF0066FF)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            skill,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            level,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPlans() {
    return Column(
      children: [
        _buildPlanCard(
          'Basic',
          '\$9.99/month',
          ['5 Job Applications', 'Basic Support', 'Standard Profile'],
          const Color(0xFF0066FF),
          false,
        ),
        const SizedBox(height: 12),
        _buildPlanCard(
          'Professional',
          '\$29.99/month',
          ['Unlimited Applications', 'Priority Support', 'Featured Profile', 'AI Recommendations'],
          const Color(0xFF00C853),
          true,
        ),
        const SizedBox(height: 12),
        _buildPlanCard(
          'Enterprise',
          '\$99.99/month',
          ['All Professional Features', 'Dedicated Manager', 'Custom Solutions', 'Advanced Analytics'],
          Colors.orange,
          false,
        ),
      ],
    );
  }

  Widget _buildPlanCard(String name, String price, List<String> features, Color color, bool featured) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: featured ? color.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: featured ? color : Colors.grey[300]!,
          width: featured ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (featured) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'POPULAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: color, size: 16),
                const SizedBox(width: 8),
                Text(
                  feature,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Choose Plan'),
          ),
        ],
      ),
    );
  }
}

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Jobs Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Messages Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workconnect/contractworkroom.dart';

void main() {
  runApp(const WorkConnect());
}

class WorkConnect extends StatelessWidget {
  const WorkConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkConnect',
      theme: ThemeData(
        primaryColor: const Color(0xFF66B2FF),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF00C853),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),

            // Banner Section
            _buildBanner(),

            // Popular Categories
            _buildCategories(),

            // Featured Freelancers
            _buildFeaturedFreelancers(),

            // Testimonials
            _buildTestimonials(),

            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Container(
            height: 50,
              width: 50,
            decoration: BoxDecoration(
              color: Color(0xFF66B2FF),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.green),
              image: DecorationImage(
                image: NetworkImage("https://copilot.microsoft.com/th/id/BCO.76bbf17c-4451-4512-aa61-013879bea5a3.png"),
                fit: BoxFit.fill,
              )
            ),
          ),
          const SizedBox(width: 20),

          // Search Bar
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search freelancers...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Buttons
          TextButton(
            onPressed: (
                ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContractWorkroomPage(),));
            },
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                color: const Color(0xFF1A1A1A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF66B2FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Sign Up',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C853),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Post a Job',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Stack(
      children: [
        Container(
          height: 400,
          width: double.infinity,
          child: Image.network(
            'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
            fit: BoxFit.cover,
          ),
        ),

        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6)
          ),
        ),

        // Phir Content (text aur search bar)
        Container(
          height: 400,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find the perfect freelance services for your business',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Connect with skilled freelancers from around the world on our secure and flexible platform.',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search for freelancers or services...',
                                  hintStyle: GoogleFonts.poppins(),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00C853),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Search',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    List<Map<String, dynamic>> categories = [
      {'icon': Icons.code, 'title': 'Development & IT'},
      {'icon': Icons.design_services, 'title': 'Design & Creative'},
      {'icon': Icons.business, 'title': 'Business'},
      {'icon': Icons.handshake, 'title': 'Marketing'},
      {'icon': Icons.description, 'title': 'Writing & Translation'},
      {'icon': Icons.architecture, 'title': 'Engineering & Architecture'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Popular Categories',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Explore services across different categories',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 2.5,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(
                      categories[index]['icon'],
                      color: const Color(0xFF0066FF),
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      categories[index]['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedFreelancers() {
    List<Map<String, dynamic>> freelancers = [
      {
        'name': 'Haider khan',
        'title': 'UX/UI Designer',
        'rating': 4.9,
        'projects': 42,
      },
      {
        'name': 'Richaer C',
        'title': 'Full Stack Developer',
        'rating': 4.8,
        'projects': 57,
      },
      {
        'name': 'Jhonson Wilson',
        'title': 'Content Writer',
        'rating': 4.7,
        'projects': 35,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          Text(
            'Featured Freelancers',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Discover top talent on our platform',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: freelancers.map((freelancer) {
              return Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile-placeholder.png'), // Add asset
                    ),
                    const SizedBox(height: 16),
                    Text(
                      freelancer['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      freelancer['title'],
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          freelancer['rating'].toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.work,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${freelancer['projects']} projects',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0066FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'View Profile',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonials() {
    List<Map<String, dynamic>> testimonials = [
      {
        'text': 'This platform helped me find the perfect developer for my startup. The process was smooth and the quality of work exceeded my expectations.',
        'author': 'Jibran Z',
        'role': 'Startup Founder',
      },
      {
        'text': 'As a freelancer, I\'ve been able to connect with clients from around the world and build a sustainable business doing what I love.',
        'author': 'Mona Lisa',
        'role': 'Graphic Designer',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'What Our Users Say',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Hear from our community of clients and freelancers',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: testimonials.map((testimonial) {
              return Container(
                width: 500,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.format_quote,
                      color: Color(0xFF0066FF),
                      size: 36,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      testimonial['text'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      testimonial['author'],
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      testimonial['role'],
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      color: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FreelancePro',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The best platform to find skilled\nfreelancers and quality work.',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'For Clients',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('How to Hire', style: GoogleFonts.poppins(color: Colors.grey[400])),
                  const SizedBox(height: 8),
                  Text('Talent Marketplace', style: GoogleFonts.poppins(color: Colors.grey[400])),
                  const SizedBox(height: 8),
                  Text('Payment Protection', style: GoogleFonts.poppins(color: Colors.grey[400])),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'For Freelancers',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('How to Find Work', style: GoogleFonts.poppins(color: Colors.grey[400])),
                  const SizedBox(height: 8),
                  Text('Get Paid', style: GoogleFonts.poppins(color: Colors.grey[400])),
                  const SizedBox(height: 8),
                  Text('Benefits', style: GoogleFonts.poppins(color: Colors.grey[400])),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resources',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Help & Support', style: GoogleFonts.poppins(color: Colors.grey[400])),
                  const SizedBox(height: 8),
                  Text('Success Stories', style: GoogleFonts.poppins(color: Colors.grey[400])),
                  const SizedBox(height: 8),
                  Text('Blog', style: GoogleFonts.poppins(color: Colors.grey[400])),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            '© 2025 Workconnect. All rights reserved.',
            style: GoogleFonts.poppins(
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
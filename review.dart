import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(ProfileReviewApp());
}

class ProfileReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freelance Marketplace Reviews',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF0066FF),
        //accentColor: Color(0xFF00C053),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF1A1A1A)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile Reviews'),
          bottom: TabBar(
            indicatorColor: Color(0xFF0066FF),
            labelColor: Color(0xFF0066FF),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Freelancer'),
              Tab(text: 'Client'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FreelancerProfileScreen(),
            ClientProfileScreen(),
          ],
        ),
      ),
    );
  }
}

class FreelancerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          _buildProfileHeader(
            name: "Sarah Johnson",
            title: "Senior UI/UX Designer",
            rating: 4.8,
            reviewCount: 124,
            avatarUrl: "assets/images/freelancer.jpeg",
          ),
          SizedBox(height: 24),

          // Overall Rating Card with unique hexagon design
          _buildHexagonRatingCard(context, 4.8, 124),
          SizedBox(height: 24),

          // Skill Ratings
          Text("Skill Ratings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 12),
          _buildSkillRatings(),
          SizedBox(height: 24),

          // Reviews
          Text("Recent Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 12),
          _buildReviewList(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader({
    required String name,
    required String title,
    required double rating,
    required int reviewCount,
    required String avatarUrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hexagon Avatar
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF0066FF), Color(0xFF00C053)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(avatarUrl),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              SizedBox(height: 4),
              Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              SizedBox(height: 8),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: rating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(width: 8),
                  Text("$rating ($reviewCount reviews)",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHexagonRatingCard(BuildContext context, double rating, int reviewCount) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0066FF).withOpacity(0.1), Color(0xFF00C053).withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Hexagon background
              CustomPaint(
                size: Size(120, 120),
                painter: HexagonPainter(),
              ),
              // Rating inside hexagon
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(rating.toString(),
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFF0066FF))),
                  RatingBar.builder(
                    initialRating: rating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 16,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text("Overall Rating", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Text("Based on $reviewCount reviews", style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildSkillRatings() {
    final skills = [
      {'name': 'UI/UX Design', 'rating': 4.9},
      {'name': 'Flutter Development', 'rating': 4.7},
      {'name': 'Communication', 'rating': 4.8},
      {'name': 'Deadline Adherence', 'rating': 5.0},
    ];

    return Column(
      children: skills.map((skill) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(skill['name'].toString(),
                    style: TextStyle(fontSize: 14)),
              ),
              Expanded(
                flex: 4,
                child: RatingBar.builder(
                  initialRating: double.parse(skill['rating'].toString()),
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(skill['rating'].toString(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReviewList() {
    final reviews = [
      {
        'name': 'Michael Chen',
        'role': 'Project Manager at TechCorp',
        'rating': 5,
        'date': '2 days ago',
        'comment': 'Sarah delivered exceptional work on our mobile app redesign. Her attention to detail and communication throughout the project were outstanding.',
        'project': 'Mobile App UI Redesign',
        'image' : 'assets/images/freelancer 1.jpeg'
      },
      {
        'name': 'Jessica Williams',
        'role': 'Startup Founder',
        'rating': 5,
        'date': '1 week ago',
        'comment': 'Great freelancer! Completed the project ahead of schedule with excellent quality. Very professional and easy to work with.',
        'project': 'E-commerce Website',
        'image' : 'assets/images/freelancer 2.jpeg'
      },
      {
        'name': 'Robert Martinez',
        'role': 'Marketing Director',
        'rating': 4,
        'date': '2 weeks ago',
        'comment': 'Good work overall. Some minor revisions were needed but Sarah was responsive and made the changes quickly.',
        'project': 'Brand Identity Design',
        'image' : 'assets/images/freelancer 3.jpeg'
      },
    ];

    return Column(
      children: reviews.map((review) {
        return _buildReviewItem(
          name: review['name'].toString(),
          role: review['role'].toString(),
          rating: int.parse(review['rating'].toString()),
          date: review['date'].toString(),
          comment: review['comment'].toString(),
          project: review['project'].toString(),
          image: review['image'].toString(),
        );
      }).toList(),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required String role,
    required int rating,
    required String date,
    required String comment,
    required String project,
    required String image,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(image),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(role, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RatingBar.builder(
                    initialRating: rating.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 16,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(height: 4),
                  Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(comment, style: TextStyle(height: 1.5)),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF0066FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Project: $project",
              style: TextStyle(fontSize: 12, color: Color(0xFF0066FF)),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text("Helpful (12)", style: TextStyle(fontSize: 12, color: Colors.grey)),
              Spacer(),
              Text("Report", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class ClientProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Client Profile Header
          _buildClientProfileHeader(
            name: "Tech Solutions Inc.",
            description: "Software Development Company",
            rating: 4.6,
            reviewCount: 89,
            avatarUrl: "assets/images/profile.PNG",
          ),
          SizedBox(height: 24),

          // Client Rating Summary
          _buildClientRatingSummary(),
          SizedBox(height: 24),

          // Client Metrics
          Text("Client Metrics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 12),
          _buildClientMetrics(),
          SizedBox(height: 24),

          // Reviews
          Text("Client Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 12),
          _buildClientReviewList(),
        ],
      ),
    );
  }

  Widget _buildClientProfileHeader({
    required String name,
    required String description,
    required double rating,
    required int reviewCount,
    required String avatarUrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Logo with hexagon border
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF0066FF), Color(0xFF00C053)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  avatarUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.business, size: 40, color: Color(0xFF0066FF));
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              SizedBox(height: 4),
              Text(description, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              SizedBox(height: 8),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: rating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(width: 8),
                  Text("$rating ($reviewCount reviews)",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClientRatingSummary() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00C053).withOpacity(0.1), Color(0xFF0066FF).withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Wrap(
        alignment: WrapAlignment.spaceAround,
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildClientRatingItem("Payment Promptness", 4.8),
            _buildClientRatingItem("Clarity of Requirements", 4.3),
            _buildClientRatingItem("Communication", 4.6),
            _buildClientRatingItem("Fairness", 4.7),
            _buildClientRatingItem("Recommendation", 4.9),
          ],
        ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClientRatingItem(String title, double rating) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(title, textAlign: TextAlign.center, softWrap: true, // wrap allow karo
              overflow: TextOverflow.visible,style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: rating / 5,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00C053)),
                  strokeWidth: 6,
                ),
              ),
              Text(rating.toStringAsFixed(1),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientMetrics() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricItem("48", "Projects Posted"),
          _buildMetricItem("92%", "Hire Rate"),
          _buildMetricItem("87%", "Repeat Hire"),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF0066FF))),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildClientReviewList() {
    final reviews = [
      {
        'name': 'Alex Thompson',
        'role': 'Freelance Developer',
        'rating': 5,
        'date': '3 days ago',
        'comment': 'Tech Solutions is one of the best clients I\'ve worked with. Clear requirements and prompt payments.',
        'project': 'API Integration',
        'image' : 'assets/images/client 1.jpeg'
      },
      {
        'name': 'John Rodriguez',
        'role': 'UI/UX Designer',
        'rating': 4,
        'date': '1 week ago',
        'comment': 'Good client with reasonable expectations. Payments were always on time.',
        'project': 'Dashboard Design',
        'image' : 'assets/images/client 2.jpeg'
      },
      {
        'name': 'James Wilson',
        'role': 'Full-stack Developer',
        'rating': 5,
        'date': '2 weeks ago',
        'comment': 'Excellent client! Provided clear specifications and was available for questions throughout the project.',
        'project': 'Web Application',
        'image' : 'assets/images/client 3.jpeg'
      },
    ];

    return Column(
      children: reviews.map((review) {
        return _buildReviewItem(
          name: review['name'].toString(),
          role: review['role'].toString(),
          rating: int.parse(review['rating'].toString()),
          date: review['date'].toString(),
          comment: review['comment'].toString(),
          project: review['project'].toString(),
          image: review['image'].toString(),
        );
      }).toList(),
    );
  }
}
Widget _buildReviewItem({
  required String name,
  required String role,
  required int rating,
  required String date,
  required String comment,
  required String project,
  required String image,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(image)
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(role, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RatingBar.builder(
                  initialRating: rating.toDouble(),
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 16,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                SizedBox(height: 4),
                Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(comment, style: TextStyle(height: 1.5)),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFF0066FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Project: $project",
            style: TextStyle(fontSize: 12, color: Color(0xFF0066FF)),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text("Helpful (12)", style: TextStyle(fontSize: 12, color: Colors.grey)),
            Spacer(),
            Text("Report", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    ),
  );
}

// Custom painter for hexagon shape
class HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF0066FF).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      double angle = 2.0 * 3.141592653589793 * i / 6;
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
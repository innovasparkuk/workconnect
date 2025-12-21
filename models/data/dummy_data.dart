import '../models/job_model.dart';

// User class definition
class User {
  final String name;
  final String role;
  final String profileImage;
  final double rating;
  final int completedJobs;
  final List<String> skills;
  final String bio;
  final String location;
  final String memberSince;

  User({
    required this.name,
    required this.role,
    required this.profileImage,
    required this.rating,
    required this.completedJobs,
    required this.skills,
    required this.bio,
    required this.location,
    required this.memberSince,
  });
}

// Chat class definition
class Chat {
  final String id;
  final String participantName;
  final String participantImage;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String jobTitle;

  Chat({
    required this.id,
    required this.participantName,
    required this.participantImage,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.jobTitle,
  });
}

class DummyData {
  static List<Job> getJobs() {
    return [
      Job(
        id: "1",
        title: "E-commerce Mobile App Development",
        clientName: "Tech Solutions Inc.",
        budget: 2500.00,
        status: "In Progress",
        description: "Develop a complete e-commerce mobile application with Flutter. The app should include user authentication, product catalog, shopping cart, payment integration, and order tracking features.",
        category: "Mobile Development",
        postedDate: DateTime.now().subtract(Duration(days: 5)),
        deadline: DateTime.now().add(Duration(days: 30)),
        location: "Remote",
        requiredSkills: ["Flutter", "Dart", "Firebase", "REST API", "Payment Integration"],
        type: "Full-time",
        clientImage: "TS",
        clientRating: "4.8",
        duration: 30,
      ),
      Job(
        id: "2",
        title: "UI/UX Design for Fitness App",
        clientName: "FitLife Studios",
        budget: 1200.00,
        status: "Pending",
        description: "Create modern and engaging UI/UX designs for a fitness tracking application. Design should be user-friendly and follow material design guidelines.",
        category: "UI/UX Design",
        postedDate: DateTime.now().subtract(Duration(days: 2)),
        deadline: DateTime.now().add(Duration(days: 14)),
        location: "Remote",
        requiredSkills: ["Figma", "UI Design", "UX Research", "Prototyping"],
        type: "Contract",
        clientImage: "FS",
        clientRating: "4.9",
        duration: 14,
      ),
      Job(
        id: "3",
        title: "Website Redesign",
        clientName: "Creative Agency Co.",
        budget: 1800.00,
        status: "Completed",
        description: "Redesign existing company website with modern responsive design. Improve user experience and update content management system.",
        category: "Web Development",
        postedDate: DateTime.now().subtract(Duration(days: 45)),
        deadline: DateTime.now().subtract(Duration(days: 15)),
        location: "New York, USA",
        requiredSkills: ["HTML/CSS", "JavaScript", "React", "Responsive Design"],
        type: "Part-time",
        clientImage: "CA",
        clientRating: "4.7",
        duration: 30,
      ),
      Job(
        id: "4",
        title: "Backend API Development",
        clientName: "Startup Ventures",
        budget: 3000.00,
        status: "In Progress",
        description: "Develop robust backend APIs for a mobile application. Implement user authentication, database design, and third-party service integrations.",
        category: "Backend Development",
        postedDate: DateTime.now().subtract(Duration(days: 10)),
        deadline: DateTime.now().add(Duration(days: 45)),
        location: "Remote",
        requiredSkills: ["Node.js", "MongoDB", "REST API", "Authentication", "AWS"],
        type: "Full-time",
        clientImage: "SV",
        clientRating: "4.5",
        duration: 45,
      ),
      Job(
        id: "5",
        title: "Social Media Marketing",
        clientName: "Brand Boosters",
        budget: 800.00,
        status: "Rejected",
        description: "Manage social media accounts and create engaging content for brand promotion. Analyze performance metrics and optimize strategies.",
        category: "Digital Marketing",
        postedDate: DateTime.now().subtract(Duration(days: 7)),
        deadline: DateTime.now().add(Duration(days: 21)),
        location: "Remote",
        requiredSkills: ["Social Media", "Content Creation", "Analytics", "Marketing"],
        type: "Freelance",
        clientImage: "BB",
        clientRating: "4.6",
        duration: 21,
      ),
      Job(
        id: "6",
        title: "Flutter Plugin Development",
        clientName: "Mobile First Ltd.",
        budget: 1500.00,
        status: "Pending Review",
        description: "Create custom Flutter plugin for advanced camera functionality. Plugin should support both iOS and Android platforms.",
        category: "Mobile Development",
        postedDate: DateTime.now().subtract(Duration(days: 3)),
        deadline: DateTime.now().add(Duration(days: 25)),
        location: "Remote",
        requiredSkills: ["Flutter", "Dart", "Native Development", "Camera API"],
        type: "Contract",
        clientImage: "MF",
        clientRating: "4.8",
        duration: 25,
      ),
      Job(
        id: "7",
        title: "Mobile App Testing",
        clientName: "Quality Assurance Pro",
        budget: 600.00,
        status: "Pending",
        description: "Perform comprehensive testing of mobile applications including functional, performance, and usability testing.",
        category: "Quality Assurance",
        postedDate: DateTime.now().subtract(Duration(days: 1)),
        deadline: DateTime.now().add(Duration(days: 10)),
        location: "Remote",
        requiredSkills: ["Testing", "QA", "Mobile Apps", "Bug Tracking"],
        type: "Part-time",
        clientImage: "QA",
        clientRating: "4.9",
        duration: 10,
      ),
      Job(
        id: "8",
        title: "Database Optimization",
        clientName: "Data Systems Corp",
        budget: 2200.00,
        status: "In Progress",
        description: "Optimize existing database performance and implement efficient data storage solutions for large-scale applications.",
        category: "Database",
        postedDate: DateTime.now().subtract(Duration(days: 8)),
        deadline: DateTime.now().add(Duration(days: 35)),
        location: "San Francisco, USA",
        requiredSkills: ["SQL", "Database Design", "Performance", "Optimization"],
        type: "Full-time",
        clientImage: "DS",
        clientRating: "4.7",
        duration: 35,
      ),
      Job(
        id: "9",
        title: "React Native App Development",
        clientName: "Innovate Tech",
        budget: 2800.00,
        status: "Pending",
        description: "Build cross-platform mobile application using React Native with focus on performance and native-like experience.",
        category: "Mobile Development",
        postedDate: DateTime.now().subtract(Duration(days: 4)),
        deadline: DateTime.now().add(Duration(days: 40)),
        location: "Remote",
        requiredSkills: ["React Native", "JavaScript", "Redux", "Firebase"],
        type: "Full-time",
        clientImage: "IT",
        clientRating: "4.8",
        duration: 40,
      ),
      Job(
        id: "10",
        title: "Logo and Brand Identity",
        clientName: "Startup Branding Co.",
        budget: 500.00,
        status: "Completed",
        description: "Design modern logo and complete brand identity package including color palette, typography, and brand guidelines.",
        category: "Graphic Design",
        postedDate: DateTime.now().subtract(Duration(days: 60)),
        deadline: DateTime.now().subtract(Duration(days: 30)),
        location: "Remote",
        requiredSkills: ["Logo Design", "Branding", "Adobe Illustrator", "Typography"],
        type: "Freelance",
        clientImage: "SB",
        clientRating: "4.9",
        duration: 7,
      ),
    ];
  }

  static User getCurrentUser() {
    return User(
      name: "John Doe",
      role: "Senior Flutter Developer",
      profileImage: "JD",
      rating: 4.8,
      completedJobs: 42,
      skills: [
        "Flutter",
        "Dart",
        "Firebase",
        "REST API",
        "UI/UX Design",
        "State Management",
        "Git",
        "Agile Methodology"
      ],
      bio: "Experienced Flutter developer with 5+ years of experience in building cross-platform mobile applications. Passionate about creating beautiful and performant apps with clean code architecture.",
      location: "New York, USA",
      memberSince: "2022",
    );
  }

  static List<Chat> getChats() {
    return [
      Chat(
        id: "1",
        participantName: "Sarah Johnson",
        participantImage: "SJ",
        lastMessage: "Hi! I've reviewed the design mockups. They look great!",
        lastMessageTime: DateTime.now().subtract(Duration(minutes: 5)),
        unreadCount: 2,
        jobTitle: "Mobile App Design",
      ),
      Chat(
        id: "2",
        participantName: "Mike Chen",
        participantImage: "MC",
        lastMessage: "When can we schedule the next meeting?",
        lastMessageTime: DateTime.now().subtract(Duration(hours: 2)),
        unreadCount: 1,
        jobTitle: "E-commerce Website",
      ),
      Chat(
        id: "3",
        participantName: "Emily Davis",
        participantImage: "ED",
        lastMessage: "Payment has been sent. Please confirm receipt.",
        lastMessageTime: DateTime.now().subtract(Duration(hours: 5)),
        unreadCount: 0,
        jobTitle: "Flutter Development",
      ),
      Chat(
        id: "4",
        participantName: "Alex Rodriguez",
        participantImage: "AR",
        lastMessage: "The API integration is working perfectly now.",
        lastMessageTime: DateTime.now().subtract(Duration(days: 1)),
        unreadCount: 0,
        jobTitle: "Backend API",
      ),
      Chat(
        id: "5",
        participantName: "Lisa Wang",
        participantImage: "LW",
        lastMessage: "Can you share the project timeline?",
        lastMessageTime: DateTime.now().subtract(Duration(days: 2)),
        unreadCount: 3,
        jobTitle: "UI/UX Design",
      ),
    ];
  }

  // Optional: Get specific chat by ID
  static Chat getChatById(String id) {
    return getChats().firstWhere((chat) => chat.id == id);
  }

  // Optional: Get jobs by status
  static List<Job> getJobsByStatus(String status) {
    return getJobs().where((job) => job.status.toLowerCase().contains(status.toLowerCase())).toList();
  }
}
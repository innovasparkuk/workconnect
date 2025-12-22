class User {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final String role;
  final double rating;
  final int completedJobs;
  final String memberSince;
  final List<String> skills;
  final String bio;
  final String location;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.role,
    required this.rating,
    required this.completedJobs,
    required this.memberSince,
    required this.skills,
    required this.bio,
    required this.location,
  });
}
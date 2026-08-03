class PortfolioData {
  final String name;
  final String title;
  final String university;
  final String degree;
  final String graduationYear;
  final String bio;
  final List<SocialLink> socialLinks;
  final List<Project> projects;
  final List<String> skills;

  PortfolioData({
    required this.name,
    required this.title,
    required this.university,
    required this.degree,
    required this.graduationYear,
    required this.bio,
    required this.socialLinks,
    required this.projects,
    required this.skills,
  });
}

class SocialLink {
  final String platform;
  final String url;
  final String icon;

  SocialLink({
    required this.platform,
    required this.url,
    required this.icon,
  });
}

class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String? url;

  Project({
    required this.title,
    required this.description,
    required this.technologies,
    this.url,
  });
}

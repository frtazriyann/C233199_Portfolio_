import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controllers/home_controller.dart';
import 'models/portfolio_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mohammad Fazle Rabbi - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Deep Slate
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF06B6D4), // Cyber Cyan
          secondary: Color(0xFF8B5CF6), // Violet
          surface: Color(0xFF1E293B), // Slate Card
        ),
      ),
      home: const PortfolioScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  // Helper method to resolve profile image
  ImageProvider _getProfileImage() {
    return const AssetImage('assets/images/profile.jpg');
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF06B6D4), Color(0xFF8B5CF6)],
                ),
              ),
              child: const Icon(Icons.code_rounded, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Text(
              'Fazle Rabbi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF06B6D4)),
            onPressed: () {
              Get.snackbar(
                'Share Portfolio',
                'Link copied to clipboard!',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF1E293B),
                colorText: Colors.white,
                borderColor: const Color(0xFF06B6D4),
                borderWidth: 1,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            // Header / Hero Section with Profile Picture and Quick Action Buttons
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0F172A),
                    const Color(0xFF1E1B4B).withValues(alpha: 0.8),
                    const Color(0xFF0F172A),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: const Border(
                  bottom: BorderSide(
                    color: Color(0xFF334155),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Animated Profile Picture frame with glow effect
                  Obx(() => GestureDetector(
                    onTap: controller.toggleProfileAnimation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: controller.profileSize.value,
                      height: controller.profileSize.value,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            controller.profileColor.value,
                            const Color(0xFF8B5CF6),
                            const Color(0xFF10B981),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: controller.profileColor.value.withValues(alpha: 0.5),
                            blurRadius: 25,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF0F172A),
                          image: DecorationImage(
                            image: _getProfileImage(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )),
                  
                  const SizedBox(height: 20),
                  
                  // Name and Title
                  Text(
                    controller.portfolioData.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 6),
                  
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF06B6D4), Color(0xFF38BDF8), Color(0xFF8B5CF6)],
                    ).createShader(bounds),
                    child: Text(
                      controller.portfolioData.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // RESTRUCTURED BUTTON PLACEMENT: Primary Hero Buttons
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      // Contact Me Call-To-Action Button
                      Obx(() => Transform.scale(
                        scale: controller.buttonScale.value,
                        child: GestureDetector(
                          onTap: () {
                            controller.toggleButtonAnimation();
                            final Uri emailUri = Uri.parse('mailto:fazlerabbi@gmail.com');
                            launchUrl(emailUri);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  controller.buttonColor.value,
                                  const Color(0xFF06B6D4),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: controller.buttonColor.value.withValues(alpha: 0.4),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.mail_outline_rounded, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Contact Me',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),

                      // Quick View Projects Button
                      OutlinedButton.icon(
                        onPressed: () {
                          scrollController.animateTo(
                            700,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.rocket_launch_outlined, size: 18, color: Color(0xFF06B6D4)),
                        label: const Text(
                          'View Work',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          side: const BorderSide(color: Color(0xFF06B6D4), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Main Content Body
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About Section
                  _buildSectionHeader(Icons.person_outline, 'About Me'),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF334155)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.portfolioData.bio,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Color(0xFF334155)),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          Icons.school_outlined,
                          controller.portfolioData.university,
                          const Color(0xFF06B6D4),
                        ),
                        const SizedBox(height: 10),
                        _buildInfoRow(
                          Icons.workspace_premium_outlined,
                          controller.portfolioData.degree,
                          const Color(0xFF8B5CF6),
                        ),
                        const SizedBox(height: 10),
                        _buildInfoRow(
                          Icons.calendar_today_outlined,
                          'Graduation Class of ${controller.portfolioData.graduationYear}',
                          const Color(0xFF10B981),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // RESTRUCTURED BUTTON PLACEMENT: Social Links Section
                  _buildSectionHeader(Icons.link_rounded, 'Connect With Me'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: controller.portfolioData.socialLinks.map((link) {
                      return _buildSocialPill(link);
                    }).toList().cast<Widget>(),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Skills Section
                  _buildSectionHeader(Icons.auto_awesome_outlined, 'Skills & Expertise'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: controller.portfolioData.skills.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF06B6D4).withValues(alpha: 0.15),
                              const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF06B6D4).withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          skill,
                          style: const TextStyle(
                            color: Color(0xFF38BDF8),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList().cast<Widget>(),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Projects Section
                  _buildSectionHeader(Icons.folder_special_outlined, 'Featured Projects'),
                  const SizedBox(height: 12),
                  Column(
                    children: controller.portfolioData.projects.asMap().entries.map((entry) {
                      final index = entry.key;
                      final project = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildProjectCard(project, index, controller),
                      );
                    }).toList().cast<Widget>(),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Animated Components Demo Section
                  _buildSectionHeader(Icons.touch_app_outlined, 'Interactive Animations'),
                  const SizedBox(height: 12),
                  
                  // Animated Card
                  Obx(() => GestureDetector(
                    onTap: controller.toggleCardAnimation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: controller.cardColor.value,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: controller.cardColor.value.withValues(alpha: 0.35),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.ads_click_rounded, color: controller.cardColor.value),
                                const SizedBox(width: 8),
                                const Text(
                                  'Tap Container to Animate',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Interactive Width State: ${controller.cardWidth.value.toInt()}px',
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF06B6D4), size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color accentColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: accentColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFCBD5E1),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialPill(SocialLink link) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF334155)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final uri = Uri.parse(link.url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  link.icon,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  link.platform,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.arrow_outward_rounded,
                  size: 14,
                  color: Color(0xFF06B6D4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(Project project, int index, HomeController controller) {
    final colors = [
      const Color(0xFF06B6D4), // Cyan
      const Color(0xFF8B5CF6), // Violet
      const Color(0xFF10B981), // Emerald
    ];
    final cardAccent = colors[index % colors.length];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: cardAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cardAccent.withValues(alpha: 0.3)),
                  ),
                  child: Center(
                    child: Text(
                      '0${index + 1}',
                      style: TextStyle(
                        color: cardAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              project.description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF94A3B8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: cardAccent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tech,
                    style: TextStyle(
                      fontSize: 12,
                      color: cardAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList().cast<Widget>(),
            ),
            
            // RESTRUCTURED BUTTON PLACEMENT inside Project Card
            if (project.url != null) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(project.url!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  icon: const Icon(Icons.open_in_new_rounded, size: 15),
                  label: const Text('View Source'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cardAccent.withValues(alpha: 0.15),
                    foregroundColor: cardAccent,
                    elevation: 0,
                    side: BorderSide(color: cardAccent.withValues(alpha: 0.4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

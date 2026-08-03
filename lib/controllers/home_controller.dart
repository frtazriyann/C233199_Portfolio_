import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/portfolio_data.dart';

class HomeController extends GetxController {
  // Component 1: Profile picture animations
  var profileSize = 110.0.obs;
  var profileColor = const Color(0xFF06B6D4).obs; // Cyan accent
  
  // Component 2: Card animations
  var cardWidth = 220.0.obs;
  var cardColor = const Color(0xFF8B5CF6).obs; // Violet accent
  
  // Component 3: Button animations
  var buttonScale = 1.0.obs;
  var buttonColor = const Color(0xFF10B981).obs; // Emerald accent

  // Portfolio data
  late PortfolioData portfolioData;

  @override
  void onInit() {
    super.onInit();
    _initPortfolioData();
    startAnimations();
  }

  void _initPortfolioData() {
    portfolioData = PortfolioData(
      name: 'Mohammad Fazle Rabbi',
      title: 'Software Engineer',
      university: 'International Islamic University Chittagong (IIUC)',
      degree: 'Bachelor of Science in Computer Science',
      graduationYear: '2027',
      bio: 'Passionate software engineer with expertise in mobile development, web applications, and cloud technologies. Love building scalable and user-friendly solutions.',
      socialLinks: [
        SocialLink(
          platform: 'GitHub',
          url: 'https://github.com/frtazriyann',
          icon: '📱',
        ),
        SocialLink(
          platform: 'LinkedIn',
          url: 'https://www.linkedin.com/in/mohammad-fazle-rabbi-tazriyan-5a5810286/',
          icon: '💼',
        ),
        SocialLink(
          platform: 'Twitter',
          url: 'https://twitter.com/tazriyan02',
          icon: '🐦',
        ),
        SocialLink(
          platform: 'Email',
          url: 'mailto:fazlerabbi@gmail.com',
          icon: '📧',
        ),
      ],
      projects: [
        Project(
          title: 'Student Management System',
          description: 'A full-featured mobile application for managing student information and academic records.',
          technologies: ['Flutter', 'Firebase'],
          url: 'https://github.com/frtazriyann/student_management',
        ),
        Project(
          title: 'IIUC Result Portal',
          description: 'Web-based project management tool with real-time collaboration features.',
          technologies: ['React', 'Node.js', 'MongoDB'],
          url: 'https://github.com/frtazriyann/IIUC-RESUT-PORTAL',
        ),
        Project(
          title: 'Note Generator Gemmini Project',
          description: 'Intelligent chatbot powered by machine learning for customer support.',
          technologies: ['Python', 'TensorFlow', 'Flask'],
          url: 'https://github.com/frtazriyann/Note_Generator_Gemmini_Project',
        ),
      ],
      skills: [
        'Flutter',
        'Dart',
        'React',
        'Node.js',
        'Python',
        'JavaScript',
        'Firebase',
        'MongoDB',
        'Git',
        'AWS',
      ],
    );
  }

  void startAnimations() {
    // Profile picture animation
    Future.delayed(const Duration(milliseconds: 500), () {
      animateProfile();
    });
    
    // Card animation
    Future.delayed(const Duration(milliseconds: 1000), () {
      animateCard();
    });
    
    // Button animation
    Future.delayed(const Duration(milliseconds: 1500), () {
      animateButton();
    });
  }

  void animateProfile() {
    profileSize.value = 130.0;
    
    Future.delayed(const Duration(milliseconds: 300), () {
      profileColor.value = const Color(0xFFEC4899); // Neon Pink
    });
    
    Future.delayed(const Duration(milliseconds: 600), () {
      profileColor.value = const Color(0xFF06B6D4); // Cyber Cyan
    });
  }

  void animateCard() {
    cardWidth.value = 260.0;
    
    Future.delayed(const Duration(milliseconds: 300), () {
      cardColor.value = const Color(0xFF3B82F6); // Electric Blue
    });
    
    Future.delayed(const Duration(milliseconds: 600), () {
      cardColor.value = const Color(0xFF8B5CF6); // Violet Accent
    });
  }

  void animateButton() {
    buttonScale.value = 1.15;
    
    Future.delayed(const Duration(milliseconds: 300), () {
      buttonColor.value = const Color(0xFFF59E0B); // Amber Gold
    });
    
    Future.delayed(const Duration(milliseconds: 600), () {
      buttonColor.value = const Color(0xFF10B981); // Emerald Accent
    });
  }

  void toggleProfileAnimation() {
    if (profileSize.value == 110.0) {
      profileSize.value = 130.0;
      profileColor.value = const Color(0xFFEC4899);
    } else {
      profileSize.value = 110.0;
      profileColor.value = const Color(0xFF06B6D4);
    }
  }

  void toggleCardAnimation() {
    if (cardWidth.value == 220.0) {
      cardWidth.value = 260.0;
      cardColor.value = const Color(0xFF3B82F6);
    } else {
      cardWidth.value = 220.0;
      cardColor.value = const Color(0xFF8B5CF6);
    }
  }

  void toggleButtonAnimation() {
    if (buttonScale.value == 1.0) {
      buttonScale.value = 1.15;
      buttonColor.value = const Color(0xFFF59E0B);
    } else {
      buttonScale.value = 1.0;
      buttonColor.value = const Color(0xFF10B981);
    }
  }
}

import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/ticker_tape.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/benefits_section.dart';
import '../widgets/differentiators_section.dart';
import '../widgets/pricing_section.dart';
import '../widgets/about_section.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/propfirms_section.dart';
import '../widgets/faq_section.dart';
import '../widgets/cta_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/particle_bg.dart'; // Add this import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey planKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey testimonialsKey = GlobalKey();
  final GlobalKey faqKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Particle Background - covers entire screen
          Positioned.fill(
            child: ParticleNetworkBackground(),
          ),

          // Content on top of particle background
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80),
                CustomTickerTape(),
                HeroSection(
                  key: homeKey,
                  pricingSectionKey: planKey,
                ),
                const StatsSection(),
                const BenefitsSection(),
                const DifferentiatorsSection(),
                PricingSection(key: planKey),
                AboutSection(key: aboutKey),
                TestimonialsSection(key: testimonialsKey),
                const PropFirmsSection(),
                FAQSection(key: faqKey),
                const CTASection(),
                const FooterSection(),
              ],
            ),
          ),

          // Navigation bar on top
          CustomNavigationBar(
            onNavigate: (section) {
              switch (section) {
                case 'home':
                  scrollToSection(homeKey);
                  break;
                case 'plan':
                  scrollToSection(planKey);
                  break;
                case 'about':
                  scrollToSection(aboutKey);
                  break;
                case 'testimonials':
                  scrollToSection(testimonialsKey);
                  break;
                case 'faq':
                  scrollToSection(faqKey);
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
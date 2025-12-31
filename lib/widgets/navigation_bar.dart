import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(String) onNavigate;

  const CustomNavigationBar({super.key, required this.onNavigate});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with SingleTickerProviderStateMixin {
  bool _isMobileMenuOpen = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                    image: AssetImage('assets/logo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      // Animated red dot
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF44336),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF44336).withOpacity(
                                      0.7 - (_pulseController.value * 0.7)),
                                  blurRadius: 10 * _pulseController.value,
                                  spreadRadius: 5 * _pulseController.value,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Scalp.tamizhan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Desktop Navigation
          if (!isMobile) ...[
            Row(
              children: [
                _buildNavLink('Home', () => widget.onNavigate('home')),
                const SizedBox(width: 40),
                _buildNavLink('Courses', () => widget.onNavigate('plan')),
                const SizedBox(width: 40),
                _buildNavLink('About Us', () => widget.onNavigate('about')),
                const SizedBox(width: 40),
                _buildNavLink(
                    'Testimonials', () => widget.onNavigate('testimonials')),
                const SizedBox(width: 40),
                _buildNavLink('FAQ', () => widget.onNavigate('faq')),
              ],
            ),
          ],

          // Mobile Menu Icon
          if (isMobile)
            IconButton(
              icon: Icon(
                _isMobileMenuOpen ? Icons.close : Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isMobileMenuOpen = !_isMobileMenuOpen;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
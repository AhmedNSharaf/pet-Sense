import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_sense/app/view/app/modules/screens/splash&onboarding/onboarding_screen.dart';

// View
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // إعداد الأنيميشن
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // بدء الأنيميشن
    _startAnimation();
  }

  void _startAnimation() async {
    // بدء أنيميشن الفيد
    _fadeController.forward();
    
    // انتظار قليل ثم بدء أنيميشن الحجم
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();
    
    // انتظار 3 ثوان ثم الانتقال لصفحة الـ onboarding
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      Get.offAll(() => OnboardingScreen());
      // أو يمكنك استخدام:
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => OnboardingScreen()),
      // );
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_scaleController, _fadeController]),
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: SizedBox(
                      child: Image.asset(
                        "assets/WhatsApp Image 2025-08-15 at 18.42.14_95491e3f 1.png",
                        fit: BoxFit.cover,
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
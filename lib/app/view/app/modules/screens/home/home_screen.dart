import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart'
    show
        PersistentBottomNavBarItem,
        PersistentTabController,
        NavBarStyle,
        PersistentTabView,
        NavBarDecoration,
        NavBarAnimationSettings,
        ItemAnimationSettings,
        ScreenTransitionAnimationType,
        ScreenTransitionAnimationSettings;

import '../pet owner/pet_owner_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2); // تبدأ من المربية
  }

  final List<Widget> _pages = [
    Scaffold(
      backgroundColor: Colors.white, // 👈 خلفية بيضاء
      body: Center(child: Text('account')),
    ),
    Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('Shop')),
    ),
    Scaffold(
      backgroundColor: Colors.white,
      body: PetOwnerHome(),
    ),
    Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('Medical Service')),
    ),
    Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('dashboard')),
    ),
  ];


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline,size: 30,),
        title: ("حسابي"),
        textStyle: GoogleFonts.cairo(
          fontWeight: FontWeight.w400,
          fontSize: 14
        ),
        activeColorPrimary: Color(0xff01727A).withOpacity(0.8),
        inactiveColorPrimary: Color(0xffA0A0A0),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/cart.svg",
          width: 30,
          height: 30,
          color: const Color(0xff01727A), // اللون في حالة التفعيل
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/cart.svg",
          width: 30,
          height: 30,
          color: const Color(0xff2c2a2a), // اللون في حالة عدم التفعيل
        ),
        title: ("المتجر"),
        textStyle: GoogleFonts.cairo(
            fontWeight: FontWeight.w400,
            fontSize: 14
        ),
        activeColorPrimary: Color(0xff01727A).withOpacity(0.8),
        inactiveColorPrimary: Color(0xffA0A0A0).withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/Vector.svg",
          width: 25,
          height: 25,
        ),
        textStyle: GoogleFonts.cairo(
            fontWeight: FontWeight.w400,
            fontSize: 14,
        ),
        activeColorPrimary: Color(0xff01727A).withOpacity(0.8),
        inactiveColorPrimary:  Color(0xffA0A0A0).withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/Baby worker.svg",
          width: 30,
          height: 30,
          color: const Color(0xff01727A), // اللون في حالة التفعيل
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/Baby worker.svg",
          width: 30,
          height: 30,
          color: const Color(0xff2c2a2a), // اللون في حالة عدم التفعيل
        ),
        title: ("المربية"),
        textStyle: GoogleFonts.cairo(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        activeColorPrimary: const Color(0xff01727A).withOpacity(0.8),
        inactiveColorPrimary: const Color(0xffA0A0A0),
      ),

      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/dashboard.svg",
          width: 50,
          height: 30,
          color: const Color(0xff01727A),
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/dashboard.svg",
          width: 50,
          height: 30,
          color: const Color(0xffA0A0A0),
        ),
        title: ("لوحة التحكم"),
        textStyle: GoogleFonts.cairo(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        activeColorPrimary: const Color(0xff01727A).withOpacity(0.8),
        inactiveColorPrimary: const Color(0xffA0A0A0),
      ),


    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      resizeToAvoidBottomInset: true,
      handleAndroidBackButtonPress: true,
      padding: const EdgeInsets.only(top: 5, bottom: 6),
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight * 1.2,
      isVisible: true,
      screens: _pages,
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      navBarStyle:
          NavBarStyle.style15, // 👈 يخلي الأيقونة اللي في النص طالعة فوق
    );
  }
}

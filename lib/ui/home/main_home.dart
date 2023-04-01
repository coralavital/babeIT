// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:babe_it/theme/theme_colors.dart';
import 'package:babe_it/ui/home/home.dart';
import 'package:babe_it/ui/home/history_list.dart';
import 'package:babe_it/ui/home/settings.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int currentPage = 0;
  final List _pages = [
    HomePage(),
    ProjectsList(),
    SettingsPage(),
  ];
  void tappedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPage],
      backgroundColor: Color.fromARGB(255, 21, 21, 37),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 15,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 60,
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: ThemeColors().grey.withOpacity(1),
              currentIndex: currentPage,
              type: BottomNavigationBarType.fixed,
              onTap: tappedPage,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    color: ThemeColors().purpleAccent,
                    fit: BoxFit.none,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/home_active.svg',
                    color: ThemeColors().blue,
                    fit: BoxFit.none,
                  ),
                  label: 'H',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/projects.svg',
                    color: ThemeColors().purpleAccent,
                    fit: BoxFit.none,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/projects_active.svg',
                    color: ThemeColors().blue,
                    fit: BoxFit.none,
                  ),
                  label: 'P',
                ),
                
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/settings.svg',
                    color: ThemeColors().purpleAccent,
                    fit: BoxFit.none,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/settings_active.svg',
                    color: ThemeColors().blue,
                    fit: BoxFit.none,
                  ),
                  label: 'S',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

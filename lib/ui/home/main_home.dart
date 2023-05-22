// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:babe_it/ui/home/notification_list.dart';
import 'package:babe_it/ui/home/history_list.dart';
import 'package:babe_it/theme/theme_colors.dart';
import '../../resources/firebase_message.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:babe_it/ui/home/account.dart';
import 'package:babe_it/ui/home/home.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int currentPage = 0;
  FMessaging messaging = FMessaging();
  final List _pages = [
    HomePage(),
    NotificationsList(),
    HistoryList(),
    ProfilePage(),
  ];
  void tappedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }
    @override
  void initState() {
    super.initState();
    messaging.requestPermission();
    messaging.getToken();
    messaging.initInfo();
    messaging.getChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPage],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.size15,
          right: Dimensions.size15,
          bottom: Dimensions.size15,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.size20),
          child: SizedBox(
            height: Dimensions.size60,
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: ThemeColors().grey,
              currentIndex: currentPage,
              type: BottomNavigationBarType.fixed,
              onTap: tappedPage,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home.svg',
                    color: ThemeColors().welcome,
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
                  icon: Icon(Icons.notifications_rounded, color: ThemeColors().welcome,),
                  activeIcon: Icon(Icons.notifications_rounded, color: ThemeColors().blue,),
                  label: 'N',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_sharp, color: ThemeColors().welcome,),
                  activeIcon: Icon(Icons.history_sharp, color: ThemeColors().blue,),
                  label: 'P',
                ),
                
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: ThemeColors().welcome,),
                  activeIcon: Icon(Icons.person, color: ThemeColors().blue,),
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

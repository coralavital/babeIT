// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 15,
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              // User card
              // BigUserCard(
              //   userName: "Babacar Ndong",
              //   userProfilePic: AssetImage("assets/logo.png"),
              //   cardActionWidget: SettingsItem(
              //     icons: Icons.edit,
              //     iconStyle: IconStyle(
              //       withBackground: true,
              //       borderRadius: 50,
              //       backgroundColor: Colors.yellow[600],
              //     ),
              //     title: "Modify",
              //     subtitle: "Tap to change your data",
              //     onTap: () {
              //       print("OK");
              //     },
              //   ),
              // ),
              // SettingsGroup(
              //   items: [
              //     SettingsItem(
              //       onTap: () {},
              //       icons: Icons.dark_mode_rounded,
              //       iconStyle: IconStyle(
              //         iconsColor: Colors.white,
              //         withBackground: true,
              //         backgroundColor: Colors.red,
              //       ),
              //       title: 'Dark mode',
              //       subtitle: "Automatic",
              //       trailing: Switch.adaptive(
              //         value: false,
              //         onChanged: (value) {},
              //       ),
              //     ),
              //   ],
              // ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'Baby Information',
                    // subtitle: "Learn more about Ziar'App",
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
                  ),
                  SettingsItem(
                    onTap: () {
                      User user = FirebaseAuth.instance.currentUser!;
                      user.delete();
                    },
                    icons: CupertinoIcons.delete_solid,
                    title: "Delete account",
                    titleStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

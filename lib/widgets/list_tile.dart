// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:badges/src/badge.dart' as badge; 
import 'package:flutter/material.dart';
import 'package:babe_it/theme/theme_colors.dart';

import '../theme/dimensions.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final String lastMessage;
  final String appLogoUrl;

  final dynamic? onTap;
  const ListTileWidget({
    super.key,
    required this.title,
    required this.lastMessage,
    required this.appLogoUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Dimensions.size15),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          height: Dimensions.size50,
          width: Dimensions.size50,
          decoration: BoxDecoration(
            color: ThemeColors().blue,
            borderRadius: BorderRadius.circular(Dimensions.size15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(appLogoUrl),
            ),
          ),
        ),
        title: Text(title),
        subtitle: Text(lastMessage),
        trailing: badge.Badge(
          badgeStyle: BadgeStyle(
            badgeColor: ThemeColors().blue,
          ),
        ),
      ),
    );
  }
}

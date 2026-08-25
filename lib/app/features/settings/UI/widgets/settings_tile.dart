import 'package:flutter/material.dart';

import '../../../../core/helper/general_sizes.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.08,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GeneralSizes.medium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: Icon(icon, color: color ?? Colors.black),
            onPressed: () {
              // Handle navigation to settings details
            },
          ),
        ],
      ),
    );
  }
}

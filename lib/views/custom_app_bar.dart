import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color backgroundColor;
  final Color titleColor;
  final Widget? leading;

  CustomAppBar({
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor = Colors.blue,
    this.titleColor = Colors.white,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      child: AppBar(
        title: Text(
          title,
          style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: centerTitle,
        actions: actions,
        leading: leading,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

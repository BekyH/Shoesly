import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;
  final String title;
  final bool isBack;
  final bool centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    Key? key,
    this.onTap,
    required this.title,
    this.isBack = false,
    this.centerTitle = false,
    this.actions,
    this.bottom
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.015),
          child: Text(
            title,
            style: titleTextStyle.copyWith(
              fontSize: 18,
            ),
          )),
      centerTitle: centerTitle,
      toolbarHeight: screenHeight * 0.1,
      leadingWidth: isBack ? screenWidth * 0.25 : null,
      automaticallyImplyLeading: false,
      leading: isBack
          ? Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.018,
                  left: screenWidth * 0.04,
                  bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.05,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      //   borderRadius: BorderRadius.circular(10),
                      onTap: onTap,
                      child: Center(child: SvgPicture.asset(Assets.backsvg)),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight( 80);
}

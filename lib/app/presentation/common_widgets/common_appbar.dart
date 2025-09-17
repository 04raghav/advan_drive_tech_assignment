import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/res/app_textstyles.dart'; // Assuming GetX is used for navigation (Navigator.pop(context))

AppBar commonAppBar({
  required BuildContext context,
  PreferredSizeWidget? bottomWidget,
  TextStyle? style,
  Color? backgroundColor,
  String? title,
  List<Widget>? actions,
  bool isShowDivider =
      false, // This parameter is currently unused in the AppBar body
  bool? isCenterTitle,
  TextAlign? textAlign,
  bool isLeading = false,
  String? leadingIcon,
  double? leadingWidth,
  Color? iconColor,
  // Removed 'drawer' parameter as it's a Scaffold property, not an AppBar property.
  // Instead, added 'showDrawer' and relevant logic.
  bool showDrawer = false, // New parameter to control hamburger icon
  GestureTapCallback? leadingOnTap, // Callback for general leading icon tap
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.white,
    // When a custom leading is provided, automaticallyImplyLeading should be false
    automaticallyImplyLeading: false,
    titleTextStyle: style,
    leading:
        // showDrawer
        //     ? GestureDetector(
        //       behavior: HitTestBehavior.opaque,
        //       onTap: () {
        //         // Safely open the drawer.
        //         // This requires the Scaffold that uses this AppBar to be in the widget tree
        //         // and accessible via BuildContext.
        //         Scaffold.of(context).openDrawer();
        //       },
        //       child: Icon(
        //         Icons.menu_rounded,
        //         size: 24, // Standard size for menu icon
        //         color: iconColor ?? AppColors.darkCharcoal,
        //       ), // Using AppColors.darkCharcoal based on screenshot
        //     )
        showDrawer
        ? Builder(
            builder: (scaffoldCtx) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Scaffold.of(scaffoldCtx).openDrawer(),
              child: Icon(
                Icons.menu_rounded,
                size: 24,
                color: iconColor ?? Colors.black,
              ),
            ),
          )
        : isLeading ==
              true // Original leading logic (back arrow or custom icon)
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // If leadingOnTap is provided, use it, otherwise default to Navigator.pop(context)
              leadingOnTap != null ? leadingOnTap() : Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: iconColor ?? Colors.black,
            ),
          )
        : leadingIcon !=
              null // If isLeading is false but a custom leadingIcon is provided
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: leadingOnTap,
            child: Image.asset(leadingIcon, scale: 4),
          )
        : Container(), // No leading widget if none of the above conditions met
    centerTitle: isCenterTitle ?? false,
    titleSpacing: 0,
    leadingWidth:
        leadingWidth ??
        (showDrawer ? 50 : 48), // Adjust leadingWidth for hamburger
    toolbarHeight: 70,
    title: Text(
      title ?? '',
      textAlign: textAlign,
      style: style ?? AppTextStyles.heading2,
    ), // Text style for title
    actions: actions ?? [],
    shadowColor: Colors.white24,
    elevation: 0,
  );
}

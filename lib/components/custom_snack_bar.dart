import '../constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  showSnackBar(
    BuildContext context, {
    required String msg,
    required SnackBarTypes snackBarTypes,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      width: double.infinity,
      content: CustomSnackBarContent(
        message: msg,
        snackBarTypes: snackBarTypes,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class CustomSnackBarContent extends StatelessWidget {
  final String message;
  final SnackBarTypes snackBarTypes;

  const CustomSnackBarContent({
    super.key,
    required this.message,
    required this.snackBarTypes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(26, 0, 26, 15),
      padding: const EdgeInsets.fromLTRB(14, 12, 9, 12),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: snackBarTypes.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: kShadowColor,
            offset: Offset(0, 4),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            snackBarTypes.prefixIcon,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(snackBarTypes.iconColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 11),
          Container(
            constraints: const BoxConstraints(maxWidth: 255),
            child: Text(
              message,
              style: TextStyle(
                color: snackBarTypes.iconColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class SnackBarTypes {
  final String prefixIcon;
  final Color iconColor;
  final Color backgroundColor;

  SnackBarTypes(this.prefixIcon, this.iconColor, this.backgroundColor);

  static SnackBarTypes error = SnackBarTypes("assets/icons/warning.svg", kColorWhite, kColorRed);
  static SnackBarTypes alert = SnackBarTypes("assets/icons/warning.svg", kSecondaryColor, kColorWhite);
  static SnackBarTypes success = SnackBarTypes("assets/icons/done_filled_circle.svg", kColorWhite, kColorGreen);
}

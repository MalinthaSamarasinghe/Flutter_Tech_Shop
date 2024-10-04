import '../constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final double buttonSize;
  final String icon;
  final double iconSize;
  final Color? iconColor;
  final Function()? onTap;
  final Decoration? btnDecoration;
  final Color bgColor;
  final String title;

  const CircleButton({
    super.key,
    this.buttonSize = 63,
    required this.icon,
    this.iconSize = 40,
    this.iconColor,
    this.onTap,
    this.btnDecoration,
    this.bgColor = kColorAddButton,
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: btnDecoration ??
                BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: iconSize,
                height: iconSize,
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: buttonSize,
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

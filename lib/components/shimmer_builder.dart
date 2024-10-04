import '../constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

/// Cash network image loading widget
Widget shimmerLoader({Widget? child}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200,
    highlightColor: Colors.grey.shade300,
    child: child ??
        Container(
          height: double.infinity,
          width: double.infinity,
          color: kColorWhite,
        ),
  );
}

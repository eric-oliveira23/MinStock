import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final Map<Platform, Map<ScreenSize, double>> fontSizes;
  final FontWeight? fontWeight;

  const ResponsiveText({
    Key? key,
    required this.text,
    required this.fontSizes,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = getPlatform(context);
    final screenSize = getScreenSize(context);
    final fontSize = fontSizes[platform]?[screenSize] ?? 14.0.sp;

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

enum Platform { android, ios, web }

enum ScreenSize { small, medium, large }

Platform getPlatform(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.android) {
    return Platform.android;
  } else if (Theme.of(context).platform == TargetPlatform.iOS) {
    return Platform.ios;
  } else {
    return Platform.web;
  }
}

ScreenSize getScreenSize(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth < 400) {
    return ScreenSize.small;
  } else if (screenWidth < 700) {
    return ScreenSize.medium;
  } else {
    return ScreenSize.large;
  }
}

final fontSizes = {
  Platform.android: {
    ScreenSize.small: 14.0.sp,
    ScreenSize.medium: 16.0.sp,
    ScreenSize.large: 18.0.sp,
  },
  Platform.ios: {
    ScreenSize.small: 15.0.sp,
    ScreenSize.medium: 17.0.sp,
    ScreenSize.large: 19.0.sp,
  },
  Platform.web: {
    ScreenSize.small: 16.0.sp,
    ScreenSize.medium: 18.0.sp,
    ScreenSize.large: 20.0.sp,
  },
};

final fontSizesSmall = {
  Platform.android: {
    ScreenSize.small: 14.0.sp,
    ScreenSize.medium: 16.0.sp,
    ScreenSize.large: 18.0.sp,
  },
  Platform.ios: {
    ScreenSize.small: 15.0.sp,
    ScreenSize.medium: 17.0.sp,
    ScreenSize.large: 19.0.sp,
  },
  Platform.web: {
    ScreenSize.small: 14.0.sp,
    ScreenSize.medium: 16.0.sp,
    ScreenSize.large: 18.0.sp,
  },
};

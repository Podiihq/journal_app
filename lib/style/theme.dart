import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {
  const Colors();

  static const Color gradientStart = const Color(0x9733ee);
  static const Color gradientEnd = const Color(0x00cdac);

  static const primaryGradient = const LinearGradient(
    colors: const[gradientStart,gradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}
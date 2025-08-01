import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsets padding;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maxWidth = 600,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width >= 600;
    final isLargePhone = screenSize.width >= 400;

    return SafeArea(
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isTablet ? maxWidth : screenSize.width,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isLargePhone ? 24 : 16,
            vertical: padding.vertical,
          ),
          child: child,
        ),
      ),
    );
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double scaleFactor;

  const ResponsiveText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.scaleFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Calculate responsive font size
    double baseFontSize = style?.fontSize ?? 16;
    double responsiveFontSize = baseFontSize * scaleFactor;

    // Adjust for very small screens
    if (screenSize.width < 350) {
      responsiveFontSize *= 0.9;
    }

    return Text(
      text,
      style: (style ?? const TextStyle()).copyWith(
        fontSize: responsiveFontSize,
      ),
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:direction/global/global.dart';

class ContainerD extends StatelessWidget {
  ContainerD({
    super.key,
    required this.child,
    this.alignment,
    this.padding,
    this.margin,
    this.color,
    this.heightModifier,
    this.widthModifier,
    this.borderRadiusV,
  });

  final Widget child;
  Alignment? alignment;
  double? padding;
  double? margin;
  Color? color;
  double? heightModifier;
  double? widthModifier;
  double? borderRadiusV;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: AnimatedContainer(
        duration: standardAnimationDuration,
        height: MediaQuery.of(context).size.height * (heightModifier ?? 0.08),
        width: MediaQuery.of(context).size.width * (widthModifier ?? 0.8),
        padding: EdgeInsets.all(padding ?? 0),
        margin: EdgeInsets.all(margin ?? 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusV ?? borderRadius),
          color: color ?? Theme.of(context).colorScheme.surface,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

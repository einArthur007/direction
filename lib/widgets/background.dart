import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Stack(
        children: [
// TOP
          FadeGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
          FadeGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
// BOTTOM
          FadeGradient(
            begin: Alignment.bottomRight,
            end: Alignment.centerLeft,
          ),
          FadeGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
          ),
        ],
      ),
    );
  }
}

class FadeGradient extends StatelessWidget {
  const FadeGradient({
    super.key,
    required this.begin,
    required this.end,
  });
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Colors.transparent,
            Colors.transparent,
          ],
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:impots_benin/useful/colors.dart';

class ProgressBar extends StatelessWidget {
  final int stepActuel;
  final int stepActuel2;

  ProgressBar({
    required this.stepActuel,
    required this.stepActuel2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final isActive = index < stepActuel;

        return Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: isActive ? mainColor : backgroundApp,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (index < 3)
              Container(
                height: 2,
                width: 40,
                color: index < stepActuel2 ? mainColor : backgroundApp,
              ),
          ],
        );
      }),
    );
  }
}

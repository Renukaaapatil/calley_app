import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CalleyLogo extends StatelessWidget {
  final double size;
  final bool showSubtitle;

  const CalleyLogo({
    Key? key,
    this.size = 64,
    this.showSubtitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Colorful Swoosh Symbol
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF00C6FF),
                Color(0xFF0072FF),
                Color(0xFF7F00FF),
                Color(0xFFFF007F),
                Color(0xFFFF7F00),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(size * 0.35),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.phone_in_talk_rounded,
              color: Colors.white,
              size: size * 0.55,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'CALLEY',
          style: TextStyle(
            color: Color(0xFF1E3A8A),
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        if (showSubtitle) ...[
          const SizedBox(height: 2),
          const Text(
            'AUTOMATIC CALL DIALER',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

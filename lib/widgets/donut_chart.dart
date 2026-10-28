import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class DonutChart extends StatefulWidget {
  final int pending;
  final int called;
  final int rescheduled;
  final double size;
  final double strokeWidth;

  const DonutChart({
    Key? key,
    required this.pending,
    required this.called,
    required this.rescheduled,
    this.size = 200,
    this.strokeWidth = 32,
  }) : super(key: key);

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void didUpdateWidget(DonutChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pending != widget.pending ||
        oldWidget.called != widget.called ||
        oldWidget.rescheduled != widget.rescheduled) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _DonutChartPainter(
            pending: widget.pending,
            called: widget.called,
            rescheduled: widget.rescheduled,
            strokeWidth: widget.strokeWidth,
            progress: _animation.value,
          ),
        );
      },
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final int pending;
  final int called;
  final int rescheduled;
  final double strokeWidth;
  final double progress;

  _DonutChartPainter({
    required this.pending,
    required this.called,
    required this.rescheduled,
    required this.strokeWidth,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final total = pending + called + rescheduled;
    if (total == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Calculate proportions
    final calledFraction = (called / total) * progress;
    final rescheduledFraction = (rescheduled / total) * progress;
    final pendingFraction = (pending / total) * progress;

    const gap = 0.05; // Gap in radians between slices
    double startAngle = -pi / 2; // Start from top

    // 1. Called / Done Segment (Blue)
    if (called > 0) {
      final sweepAngle = (calledFraction * 2 * pi) - gap;
      if (sweepAngle > 0) {
        final paintCalled = Paint()
          ..color = AppColors.primary
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;
        canvas.drawArc(rect, startAngle + gap / 2, sweepAngle, false, paintCalled);
        startAngle += calledFraction * 2 * pi;
      }
    }

    // 2. Rescheduled Segment (Purple)
    if (rescheduled > 0) {
      final sweepAngle = (rescheduledFraction * 2 * pi) - gap;
      if (sweepAngle > 0) {
        final paintRescheduled = Paint()
          ..color = AppColors.rescheduled
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;
        canvas.drawArc(rect, startAngle + gap / 2, sweepAngle, false, paintRescheduled);
        startAngle += rescheduledFraction * 2 * pi;
      }
    }

    // 3. Pending Segment (Yellow/Orange)
    if (pending > 0) {
      final sweepAngle = (pendingFraction * 2 * pi) - gap;
      if (sweepAngle > 0) {
        final paintPending = Paint()
          ..color = AppColors.pending
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;
        canvas.drawArc(rect, startAngle + gap / 2, sweepAngle, false, paintPending);
      }
    }
  }

  @override
  bool shouldRepaint(_DonutChartPainter oldDelegate) {
    return oldDelegate.pending != pending ||
        oldDelegate.called != called ||
        oldDelegate.rescheduled != rescheduled ||
        oldDelegate.progress != progress;
  }
}

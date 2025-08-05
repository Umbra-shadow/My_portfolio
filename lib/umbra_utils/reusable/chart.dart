import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/color.dart'; // Ensure this path is correct

class ChartDataPoint {
  final String label;
  final double value;

  const ChartDataPoint({required this.label, required this.value});
}

class UserChart extends StatefulWidget {
  final List<ChartDataPoint> data;

  const UserChart({super.key, required this.data});

  @override
  State<UserChart> createState() => _UserChartState();
}

class _UserChartState extends State<UserChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant UserChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return Center(
        child: Text(
          "No user growth data available.",
          style: GoogleFonts.poppins(color: AppColors.textPrimaryWhite),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onPanUpdate: (details) {
              final box = context.findRenderObject() as RenderBox;
              final localPos = box.globalToLocal(details.globalPosition);
              final double segmentWidth =
                  widget.data.length > 1
                      ? box.size.width / (widget.data.length - 1)
                      : box.size.width;
              final index = (localPos.dx / segmentWidth).round().clamp(
                0,
                widget.data.length - 1,
              );
              setState(() => _hoveredIndex = index);
            },
            onPanEnd: (_) => setState(() => _hoveredIndex = null),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _LineChartPainter(
                    data: widget.data,
                    animationProgress: _animationController.value,
                    hoveredIndex: _hoveredIndex,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Divider(color: Colors.grey.shade300.withOpacity(0.5), height: 1),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              widget.data.map((data) {
                return Text(
                  data.label,
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryBlack,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<ChartDataPoint> data;
  final double animationProgress;
  final int? hoveredIndex;

  _LineChartPainter({
    required this.data,
    required this.animationProgress,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    final points = _getPoints(size, maxValue);

    final path = _createPath(points);
    final animatedPath = _createAnimatedPath(path, animationProgress);

    final fillPaint =
        Paint()
          ..shader = ui.Gradient.linear(Offset(0, size.height), Offset(0, 0), [
            AppColors.dashboardGreen.withOpacity(0.0),
            AppColors.dashboardGreen.withOpacity(0.3),
          ]);
    final fillPath =
        Path.from(animatedPath)
          ..lineTo(points.last.dx, size.height)
          ..lineTo(points.first.dx, size.height)
          ..close();
    canvas.drawPath(fillPath, fillPaint);

    final linePaint =
        Paint()
          ..color = AppColors.dashboardGreen
          ..strokeWidth = 3.5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
    canvas.drawPath(animatedPath, linePaint);

    for (int i = 0; i < points.length; i++) {
      if ((i / (points.length - 1).clamp(1, 100)) > animationProgress) break;
      final isHovered = i == hoveredIndex;
      final pointPaint =
          Paint()
            ..color =
                isHovered
                    ? AppColors.dashboardGreen.withOpacity(0.8)
                    : AppColors.dashboardGreen;
      final innerPointPaint = Paint()..color = AppColors.textSecondaryWhite;

      canvas.drawCircle(points[i], isHovered ? 8 : 5, pointPaint);
      canvas.drawCircle(points[i], isHovered ? 5 : 2, innerPointPaint);

      if (isHovered) {
        _drawTooltip(canvas, size, points[i], data[i].value);
      }
    }
  }

  List<Offset> _getPoints(Size size, double maxValue) {
    if (maxValue == 0) maxValue = 1;
    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      final x =
          data.length == 1
              ? size.width / 2
              : (i / (data.length - 1)) * size.width;
      final y = size.height - (data[i].value / maxValue * size.height);
      points.add(Offset(x, y));
    }
    return points;
  }

  Path _createPath(List<Offset> points) {
    final path = Path();
    if (points.isEmpty) return path;
    path.moveTo(points.first.dx, points.first.dy);

    for (var i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p2.dx,
        p2.dy,
      );
    }
    return path;
  }

  Path _createAnimatedPath(Path originalPath, double animationPercent) {
    if (originalPath.computeMetrics().isEmpty) return Path();
    final totalLength = originalPath.computeMetrics().first.length;
    final currentLength = totalLength * animationPercent;
    return originalPath.computeMetrics().first.extractPath(0.0, currentLength);
  }

  void _drawTooltip(Canvas canvas, Size size, Offset point, double value) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: value.toInt().toString(),
        style: GoogleFonts.poppins(
          color: AppColors.textPrimaryBlack,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: point - const Offset(0, 25),
        width: textPainter.width + 16,
        height: textPainter.height + 8,
      ),
      const Radius.circular(8),
    );

    canvas.drawRRect(rrect, Paint()..color = AppColors.backgroundSlate);
    textPainter.paint(
      canvas,
      rrect.center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.hoveredIndex != hoveredIndex ||
        oldDelegate.data != data;
  }
}

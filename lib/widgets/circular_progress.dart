import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgress extends StatefulWidget {
  final double porcentaje;
  final double strokeWidth;
  final Color colorCircle;
  final Color colorArc;
  final Duration duration;
  const CircularProgress({
    required this.porcentaje,
    this.strokeWidth = 10,
    this.colorCircle = Colors.grey,
    this.colorArc = Colors.pink,
    this.duration = const Duration(milliseconds: 300),
    super.key,
  });

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double porcentajeAnterior;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    porcentajeAnterior = widget.porcentaje;

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward(from: 0.0);
    double diferenciAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: CircularPainter(
              porcentaje: (porcentajeAnterior - diferenciAnimar) +
                  (diferenciAnimar * animationController.value),
              strokeWidth: widget.strokeWidth,
              colorCircle: widget.colorCircle,
              colorArc: widget.colorArc,
            ),
          ),
        );
      },
    );
  }
}

class CircularPainter extends CustomPainter {
  final double porcentaje;
  final double strokeWidth;
  final Color colorCircle;
  final Color colorArc;
  final Gradient gradient = const LinearGradient(
    colors: [
      Color(0xFFF58529),
      // Azul púrpura
      Color(0xFF5851DB), // Púrpura
      Color(0xFFDD2A7B), // Morado
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  CircularPainter({
    required this.porcentaje,
    required this.strokeWidth,
    required this.colorCircle,
    required this.colorArc,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = colorCircle
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);

    double radio = min(
          size.width * 0.5,
          size.height * 0.5,
        ) -
        strokeWidth * 0.5;

    canvas.drawCircle(center, radio, paint);
    Rect rect = Rect.fromCircle(
      center: const Offset(0, 0),
      radius: 180,
    );
    final paintArc = Paint()
      ..strokeWidth = strokeWidth
      //..color = colorArc
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //Sombra
    //..maskFilter = MaskFilter.blur(BlurStyle.normal, 10)

    final arcAngle = 2 * pi * (porcentaje / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radio),
      -pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(CircularPainter oldDelegate) => true;
}

import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgresPage extends StatefulWidget {

  const CircularProgresPage({
   
    super.key,
  });

  @override
  State<CircularProgresPage> createState() => _CircularProgresPageState();
}

class _CircularProgresPageState extends State<CircularProgresPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double porcentaje = 0.0;
  double basep = 0.0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.transparent,
          child: CustomPaint(
            painter: MyPainter(
              porcentaje: basep + ((porcentaje - basep) * controller.value),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          if (porcentaje >= 100) {
            porcentaje = 0;
            basep = 0;
          } else {
            basep = porcentaje;
            porcentaje += 20;
          }

          setState(() {
            controller.forward(from: 0.0);
          });
        },
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double porcentaje;
  final double strokeWidth = 50;

  MyPainter({super.repaint, required this.porcentaje});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);

    double radio = min(
      size.width * 0.5,
      size.height * 0.5,
    );

    canvas.drawCircle(center, radio, paint);

    final paintArc = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

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
  bool shouldRepaint(MyPainter oldDelegate) => true;
}

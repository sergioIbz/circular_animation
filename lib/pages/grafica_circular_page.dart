import 'package:circular_animation/widgets/circular_progress.dart';
import 'package:flutter/material.dart';

class GraficaCircularPage extends StatefulWidget {
  const GraficaCircularPage({super.key});

  @override
  State<GraficaCircularPage> createState() => _GraficaCircularPageState();
}

class _GraficaCircularPageState extends State<GraficaCircularPage>
    with SingleTickerProviderStateMixin {
  double porcentaje = 0;
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    controller.repeat();
    controller.addListener(
      () {
        setState(() {
          porcentaje = 100 * controller.value;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: CircularProgress(
                  porcentaje: porcentaje,
                  strokeWidth: 16,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://dashtronaut.app/static/logo-c8592a2a25aed2ef9ab709478e57f337.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          if (porcentaje >= 100) {
            porcentaje = 0;
          } else {
            porcentaje += 10;
          }
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}

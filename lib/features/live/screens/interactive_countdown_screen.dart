import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/countdown_widget.dart';

class InteractiveCountdownScreen extends StatelessWidget {
  final String eventName;
  final DateTime targetTime;
  const InteractiveCountdownScreen({super.key, required this.eventName, required this.targetTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(eventName, style: const TextStyle(color: LiveColors.text, fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            CountdownWidget(targetTime: targetTime),
          ]),
        ),
      ),
    );
  }
}

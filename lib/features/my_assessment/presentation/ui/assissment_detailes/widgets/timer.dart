import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class CountdownTimer extends StatefulWidget {
  final num totalSeconds;
  final VoidCallback onTimeUp;

  const CountdownTimer({
    super.key,
    required this.totalSeconds,
    required this.onTimeUp,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late num remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.totalSeconds;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remaining == 0) {
        timer.cancel();
        widget.onTimeUp();
      } else {
        setState(() => remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = remaining ~/ 60;
    final seconds = (remaining % 60).toString().padLeft(2, '0');

    final bool isEnding = remaining <= 10;
    final Color backgroundColor = isEnding ? Colors.red : AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(width: 1, color: AppColors.subPrimary),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        "$minutes:$seconds",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: backgroundColor,
        ),
      ),
    );
  }
}

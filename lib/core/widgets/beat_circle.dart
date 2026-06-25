import 'package:flutter/material.dart';

class BeatCircle extends StatefulWidget {
  const BeatCircle({
    super.key,
    required this.beatNumber,
    this.isAnimating = false,
    this.beatProgress = 0.0,
    this.showProgress = false,
  });

  final int beatNumber;
  final bool isAnimating;
  final double beatProgress;
  final bool showProgress;

  @override
  State<BeatCircle> createState() => _BeatCircleState();
}

class _BeatCircleState extends State<BeatCircle> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _pulse = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(BeatCircle old) {
    super.didUpdateWidget(old);
    if (widget.isAnimating && widget.beatNumber != old.beatNumber) {
      _pulseController.forward().then((_) => _pulseController.reverse());
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _pulse,
          builder: (_, child) => Transform.scale(scale: _pulse.value, child: child),
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF2D6A9F)),
            child: Center(
              child: Text(
                '${widget.beatNumber}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 48),
              ),
            ),
          ),
        ),
        if (widget.showProgress && widget.isAnimating) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: LinearProgressIndicator(
              value: widget.beatProgress,
              backgroundColor: Color(0xFFDDE5F0),
            ),
          ),
        ],
      ],
    );
  }
}

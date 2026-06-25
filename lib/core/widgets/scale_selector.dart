import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ScaleSelector extends StatelessWidget {
  const ScaleSelector({
    super.key,
    required this.selectedScale,
    required this.onMinusPressed,
    required this.onPlusPressed,
  });

  final String selectedScale;
  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('SCALE', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colors.textSecondary)),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _circleButton(Icons.remove, onMinusPressed, colors),
            const SizedBox(width: 8),
            Container(
              width: 50, height: 36,
              decoration: BoxDecoration(
                border: Border.all(color: colors.cardBorder),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  selectedScale,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            _circleButton(Icons.add, onPlusPressed, colors),
          ],
        ),
      ],
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onPressed, AppColors colors) {
    return SizedBox(
      width: 36, height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: onPressed,
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}

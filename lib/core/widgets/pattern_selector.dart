import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PatternSelector extends StatelessWidget {
  const PatternSelector({
    super.key,
    required this.pattern,
    required this.onPreviousPressed,
    required this.onNextPressed,
  });

  final String pattern;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 36, height: 36,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_left),
            color: colors.primary,
            onPressed: onPreviousPressed,
            tooltip: 'Previous pattern',
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: colors.cardBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                pattern,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 36, height: 36,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_right),
            color: colors.primary,
            onPressed: onNextPressed,
            tooltip: 'Next pattern',
          ),
        ),
      ],
    );
  }
}

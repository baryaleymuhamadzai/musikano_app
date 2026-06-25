import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MasterPlayToggle extends StatelessWidget {
  const MasterPlayToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'MASTER PLAY',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(width: 8),
        Switch.adaptive(
          activeColor: colors.accent,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

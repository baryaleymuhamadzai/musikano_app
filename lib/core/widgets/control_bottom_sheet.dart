import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ControlBottomSheet extends StatefulWidget {
  const ControlBottomSheet({
    super.key,
    required this.title,
    required this.initialValue,
    required this.min,
    required this.max,
    this.divisions,
    required this.onApply,
    this.valueSuffix = '',
    this.formatValue,
  });

  final String title;
  final double initialValue;
  final double min;
  final double max;
  final int? divisions;
  final void Function(int value) onApply;
  final String valueSuffix;
  final String Function(int)? formatValue;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required int initialValue,
    required int min,
    required int max,
    int? divisions,
    required void Function(int value) onApply,
    String valueSuffix = '',
    String Function(int)? formatValue,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => ControlBottomSheet(
        title: title,
        initialValue: initialValue.toDouble(),
        min: min.toDouble(),
        max: max.toDouble(),
        divisions: divisions ?? (max - min).abs(),
        onApply: onApply,
        valueSuffix: valueSuffix,
        formatValue: formatValue,
      ),
    );
  }

  @override
  State<ControlBottomSheet> createState() => _ControlBottomSheetState();
}

class _ControlBottomSheetState extends State<ControlBottomSheet> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final display = widget.formatValue?.call(_value.round()) ?? '${_value.round()}${widget.valueSuffix}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
              Text(
                display,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: colors.primary),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Slider(
            value: _value,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            activeColor: colors.primary,
            onChanged: (v) => setState(() => _value = v),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  widget.onApply(_value.round());
                  Navigator.pop(context);
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

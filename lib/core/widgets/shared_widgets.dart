import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class InstrumentCardShell extends StatelessWidget {
  const InstrumentCardShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.cardBorder, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: child,
    );
  }
}

class SectionTab extends StatelessWidget {
  const SectionTab({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: List.generate(
        tabs.length,
        (index) => Expanded(
          child: InkWell(
            onTap: () => onTabChanged(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: index == selectedIndex ? colors.primary : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  tabs[index],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: index == selectedIndex ? colors.primary : colors.textSecondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.message});
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: colors.textHint),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PremiumBanner extends StatefulWidget {
  const PremiumBanner({super.key, required this.onGetPremiumPressed});
  final VoidCallback onGetPremiumPressed;

  @override
  State<PremiumBanner> createState() => _PremiumBannerState();
}

class _PremiumBannerState extends State<PremiumBanner> {
  bool _isDismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) return const SizedBox.shrink();

    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      color: colors.primaryLight.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'For more taals, tanpuras and scales',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textPrimary),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: widget.onGetPremiumPressed,
            child: const Text('GET PREMIUM'),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.close, size: 18),
              onPressed: () => setState(() => _isDismissed = true),
            ),
          ),
        ],
      ),
    );
  }
}

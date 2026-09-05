import 'package:flutter/material.dart';

import '../../../../../core/app_theme.dart';
import '../../../../../core/helper/general_sizes.dart';
import '../../../../../core/widgets/custom_text.dart';

class SearchModeSwitcher extends StatefulWidget {
  const SearchModeSwitcher({
    super.key,
    required this.selectedMode,
    required this.onChanged,
  });

  final String selectedMode;
  final ValueChanged<String> onChanged;

  @override
  State<SearchModeSwitcher> createState() => _SearchModeSwitcherState();
}

class _SearchModeSwitcherState extends State<SearchModeSwitcher> {
  late String _selectedMode = widget.selectedMode;

  void _selectMode(String mode) {
    if (mode == _selectedMode) return;
    setState(() => _selectedMode = mode);
    widget.onChanged(mode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        border: Border.all(color: AppColors.primaryRich, width: 2),
        borderRadius: BorderRadius.circular(borderRadiusM),
      ),
      child: Row(
        children: [
          _ModeOption(
            label: 'بحث مطابق',
            mode: 'EXACT',
            selectedMode: _selectedMode,
            onTap: _selectMode,
          ),
          _ModeOption(
            label: 'بحث مرن',
            mode: 'FLEXIBLE',
            selectedMode: _selectedMode,
            onTap: _selectMode,
          ),
        ],
      ),
    );
  }
}

class _ModeOption extends StatelessWidget {
  const _ModeOption({
    required this.label,
    required this.mode,
    required this.selectedMode,
    required this.onTap,
  });

  final String label;
  final String mode;
  final String selectedMode;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = mode == selectedMode;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadiusM - 2),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            style: TextStyle(
              color: isSelected ? AppColors.textWhite : AppColors.textPrimary,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
            child: CustomText(text: label),
          ),
        ),
      ),
    );
  }
}

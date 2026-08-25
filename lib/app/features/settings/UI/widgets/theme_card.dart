import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/theme/logic/theme_cubit.dart';
import '../../../../core/theme/logic/theme_state.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_container.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({super.key});

  static const primaryColors = [
    Color(0xffC59653),
    Color(0xff2AC17E),
    Color(0xff35A2FF),
    Color(0xffEF3F4C),
    Color(0xff736C8B),
    Color(0xff24B4AA),
  ];

  static const secondaryColors = [
    Color(0xffFFF1E1),
    Color(0xffE8F7EF),
    Color(0xffE8F3FF),
    Color(0xffffe8ea),
    Color(0xffF0ECF8),
    Color(0xffE5F7F5),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => _showThemeSheet(context),
          child: UniversalContainer(
            heightPortion: .18,
            widthPortion: .9,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ColorMatrix(
                    primary: state.primary,
                    secondary: state.secondary,
                  ),
                  Expanded(
                    child: CustomText(
                      text: 'اختيار ألوان التطبيق',
                      color: state.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showThemeSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.secondary,
      builder: (_) => const _ThemePickerSheet(),
    );
  }
}

class _ColorMatrix extends StatelessWidget {
  const _ColorMatrix({required this.primary, required this.secondary});

  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: ThemeCard.primaryColors
              .take(3)
              .map(
                (color) => _ColorDot(color: color, selected: color == primary),
              )
              .toList(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: ThemeCard.secondaryColors
              .take(3)
              .map(
                (color) =>
                    _ColorDot(color: color, selected: color == secondary),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ThemePickerSheet extends StatelessWidget {
  const _ThemePickerSheet();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(
                text: 'اللون الأساسي',
                color: state.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 12),
              _ColorOptions(
                colors: ThemeCard.primaryColors,
                selected: state.primary,
                onSelected: context.read<ThemeCubit>().selectPrimary,
              ),
              const SizedBox(height: 24),
              CustomText(
                text: 'اللون الثانوي',
                color: state.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 12),
              _ColorOptions(
                colors: ThemeCard.secondaryColors,
                selected: state.secondary,
                onSelected: context.read<ThemeCubit>().selectSecondary,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: state.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'هذا مثال على ألوان النص الحالية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: state.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ColorOptions extends StatelessWidget {
  const _ColorOptions({
    required this.colors,
    required this.selected,
    required this.onSelected,
  });

  final List<Color> colors;
  final Color selected;
  final ValueChanged<Color> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 18,
      runSpacing: 14,
      children: colors
          .map(
            (color) => GestureDetector(
              onTap: () => onSelected(color),
              child: _ColorDot(color: color, selected: color == selected),
            ),
          )
          .toList(),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.color, required this.selected});

  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: color,
        child: selected
            ? Icon(
                Icons.check,
                size: 18,
                color:
                    ThemeData.estimateBrightnessForColor(color) ==
                        Brightness.dark
                    ? Colors.white
                    : Colors.black54,
              )
            : null,
      ),
    );
  }
}

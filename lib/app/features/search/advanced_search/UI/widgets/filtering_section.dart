import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';

class FilteringSection extends StatefulWidget {
  const FilteringSection({super.key});

  @override
  State<FilteringSection> createState() => _FilteringSectionState();
}

class _FilteringSectionState extends State<FilteringSection> {
  final List<_FilterGroupData> _groups = const [
    _FilterGroupData(
      title: 'التصنيف',
      options: ['التصنيف A', 'التصنيف B', 'التصنيف C'],
    ),
    _FilterGroupData(title: 'المصدر', options: ['المصدر 1', 'المصدر 2']),
    _FilterGroupData(
      title: 'الخاصية',
      options: ['خاصية X', 'خاصية Y', 'خاصية Z'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        border: Border.all(color: AppColors.primaryRich, width: 2),
        borderRadius: BorderRadius.circular(borderRadiusM),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: GeneralSizes.small),
        childrenPadding: const EdgeInsets.all(GeneralSizes.small),
        backgroundColor: transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusM),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(borderRadiusM),
        ),
        collapsedBackgroundColor: AppColors.primaryLight,
        iconColor: Colors.transparent,
        collapsedIconColor: Colors.transparent,
        title: CustomText(
          text: 'اعدادات البحث',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        trailing: const SizedBox.shrink(),
        children: _groups
            .map(
              (group) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _FilterGroupCard(data: group),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _FilterGroupData {
  const _FilterGroupData({required this.title, required this.options});

  final String title;
  final List<String> options;
}

class _FilterGroupCard extends StatefulWidget {
  const _FilterGroupCard({required this.data});

  final _FilterGroupData data;

  @override
  State<_FilterGroupCard> createState() => _FilterGroupCardState();
}

class _FilterGroupCardState extends State<_FilterGroupCard> {
  late final List<bool> _selected;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _selected = List<bool>.filled(widget.data.options.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadiusM),
        border: Border.all(color: AppColors.primaryRich),
      ),
      child: ExpansionTile(
        key: PageStorageKey<String>(widget.data.title),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(borderRadiusM),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: GeneralSizes.small),
        childrenPadding: const EdgeInsets.fromLTRB(
          GeneralSizes.small,
          0,
          GeneralSizes.small,
          GeneralSizes.small,
        ),
        iconColor: Colors.transparent,
        collapsedIconColor: Colors.transparent,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(borderRadiusM),
        ),
        trailing: const SizedBox.shrink(),
        title: CustomText(
          text: widget.data.title,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        onExpansionChanged: (value) => setState(() => _isExpanded = value),
        initiallyExpanded: false,
        children: [
          Column(
            children: List.generate(widget.data.options.length, (index) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(widget.data.options[index]),
                value: _selected[index],
                onChanged: (value) {
                  setState(() => _selected[index] = value ?? false);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

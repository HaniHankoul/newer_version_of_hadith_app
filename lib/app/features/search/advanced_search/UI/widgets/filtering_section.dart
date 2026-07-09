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
  final List<List<String>> _options = [
    ['التصنيف A', 'التصنيف B', 'التصنيف C'],
    ['المصدر 1', 'المصدر 2'],
    ['خاصية X', 'خاصية Y', 'خاصية Z'],
  ];

  late List<bool> _isExpanded;
  late List<List<bool>> _selected;

  @override
  void initState() {
    super.initState();
    _isExpanded = List<bool>.filled(_options.length, false);
    _selected = _options
        .map((opts) => List<bool>.filled(opts.length, false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        border: Border.all(color: AppColors.primaryRich, width: 2),
        borderRadius: BorderRadius.circular(borderRadiusM),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(GeneralSizes.small),
            child: CustomText(
              text: 'اعدادات البحث',
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              setState(
                () => _isExpanded[panelIndex] = !_isExpanded[panelIndex],
              );
            },
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return Container(
                    width: MediaQuery.of(context).size.width * .85,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      border: Border.all(
                        color: AppColors.primaryRich,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(borderRadiusM),
                    ),
                    child: CustomText(text: 'text'),
                  );
                },
                body: Column(),
              ),
            ],
          ),
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              setState(
                () => _isExpanded[panelIndex] = !_isExpanded[panelIndex],
              );
            },
            children: List.generate(_options.length, (panelIndex) {
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.all(GeneralSizes.small),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'قسم ${panelIndex + 1}',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                        ),
                      ],
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: Column(
                    children: List.generate(_options[panelIndex].length, (i) {
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(_options[panelIndex][i]),
                        value: _selected[panelIndex][i],
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (v) => setState(
                          () => _selected[panelIndex][i] = v ?? false,
                        ),
                      );
                    }),
                  ),
                ),
                isExpanded: _isExpanded[panelIndex],
                canTapOnHeader: true,
              );
            }),
          ),
        ],
      ),
    );
  }
}

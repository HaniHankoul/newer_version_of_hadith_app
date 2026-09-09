import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import '../../data/models/search_filters_model.dart';

class FilteringSection extends StatefulWidget {
  const FilteringSection({
    super.key,
    required this.filters,
    required this.onChanged,
  });

  final FilterModel filters;
  final ValueChanged<Map<String, List<String>>> onChanged;

  @override
  State<FilteringSection> createState() => _FilteringSectionState();
}

class _FilteringSectionState extends State<FilteringSection> {
  final Map<String, List<String>> _selected = {};
  int _resetSignal = 0;

  List<_FilterGroupData> get _groups => [
    _FilterGroupData('الكتب', widget.filters.books ?? [], 'bookIds'),
    _FilterGroupData(
      'المحدثون',
      widget.filters.muhaddiths ?? [],
      'muhaddithIds',
    ),
    _FilterGroupData('الرواة', widget.filters.rawis ?? [], 'rawiIds'),
    _FilterGroupData('الأحكام', widget.filters.rulings ?? [], 'rulingIds'),
    _FilterGroupData('المواضيع', widget.filters.topics ?? [], 'topicIds'),
    _FilterGroupData(
      'التصنيف',
      (widget.filters.types ?? [])
          .map((type) => Book(id: type.id, name: _arabicTypeLabel(type.label)))
          .toList(growable: false),
      'types',
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
        trailing: TextButton.icon(
          onPressed: _selected.isEmpty
              ? null
              : () {
                  setState(() {
                    _selected.clear();
                    _resetSignal++;
                  });
                  widget.onChanged(<String, List<String>>{});
                },
          icon: const Icon(Icons.clear_all, size: 18),
          label: const Text('مسح الكل'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            disabledForegroundColor: AppColors.darkGrey,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: const Size(0, 36),
          ),
        ),
        children: _groups
            .map(
              (group) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _FilterGroupCard(
                  data: group,
                  resetSignal: _resetSignal,
                  selectedIds: _selected[group.key] ?? [],
                  onChanged: (ids) {
                    setState(() => _selected[group.key] = ids);
                    widget.onChanged(Map.unmodifiable(_selected));
                  },
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _FilterGroupData {
  const _FilterGroupData(this.title, this.options, this.key);

  final String title;
  final List<Book> options;
  final String key;
}

class _FilterGroupCard extends StatefulWidget {
  const _FilterGroupCard({
    required this.data,
    required this.resetSignal,
    required this.selectedIds,
    required this.onChanged,
  });

  final _FilterGroupData data;
  final int resetSignal;
  final List<String> selectedIds;
  final ValueChanged<List<String>> onChanged;

  @override
  State<_FilterGroupCard> createState() => _FilterGroupCardState();
}

class _FilterGroupCardState extends State<_FilterGroupCard> {
  static const double _optionsMaxHeight = 320;

  late List<bool> _selected;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.data.options
        .map((option) => widget.selectedIds.contains(option.id))
        .toList();
  }

  @override
  void didUpdateWidget(covariant _FilterGroupCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.resetSignal != oldWidget.resetSignal) {
      _selected = List<bool>.filled(widget.data.options.length, false);
    }
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
        onExpansionChanged: (value) => setState(() => isExpanded = value),
        initiallyExpanded: false,
        children: [
          SizedBox(
            height: _optionsMaxHeight,
            child: ListView.builder(
              primary: false,
              itemCount: widget.data.options.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(widget.data.options[index].name ?? ''),
                  value: _selected[index],
                  onChanged: (value) {
                    setState(() => _selected[index] = value ?? false);
                    widget.onChanged([
                      for (var i = 0; i < _selected.length; i++)
                        if (_selected[i] && widget.data.options[i].id != null)
                          widget.data.options[i].id!,
                    ]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String _arabicTypeLabel(String? label) {
  switch (label?.trim().toLowerCase()) {
    case 'marfu':
      return 'مرفوع';
    case 'mawquf':
      return 'موقوف';
    case 'qudsi':
      return 'قدسي';
    case 'atharsahaba':
    case 'athar_sahaba':
      return 'أثر الصحابة';
    case 'mursal':
      return 'مرسل';
    case 'muallaq':
      return 'معلّق';
    case 'maqtu':
      return 'مقطوع';
    default:
      return label ?? '';
  }
}

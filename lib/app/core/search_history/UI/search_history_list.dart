import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hugeicons/hugeicons.dart';

import '../logic/search_history_cubit.dart';
import '../logic/search_history_states.dart';

class SearchHistoryList extends StatelessWidget {
  const SearchHistoryList({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchHistoryCubit, SearchHistoryState>(
      builder: (context, state) {
        // if (state is SearchHistoryLoading) {
        //   return const Padding(
        //     padding: EdgeInsets.all(12),
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // }
        if (state is! SearchHistoryLoaded || state.items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Material(
          elevation: 10,
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 10, 4),
                child: Row(
                  children: [
                    HugeIcon(icon: HugeIcons.strokeRoundedTransactionHistory),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'عمليات البحث الأخيرة',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: context.read<SearchHistoryCubit>().clearAll,
                      child: Text(
                        'مسح الكل',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
              ...state.items.map(
                (item) => ListTile(
                  dense: true,
                  leading: const Icon(Icons.history_outlined, size: 20),
                  title: Text(
                    item.searchText ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => onSelected(item.searchText ?? ''),
                  trailing: IconButton(
                    tooltip: 'حذف البحث',
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: item.id == null
                        ? null
                        : () => context.read<SearchHistoryCubit>().deleteItem(
                            item.id!,
                          ),
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

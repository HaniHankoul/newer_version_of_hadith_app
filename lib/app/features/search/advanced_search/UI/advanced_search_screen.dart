import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/widgets/custom_text_field.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/search_history/UI/search_history_list.dart';
import '../../../../core/search_history/logic/search_history_cubit.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/hadith_card.dart';
import '../logic/advanced_search_cubit.dart';
import '../logic/advanced_search_states.dart';
import 'widgets/filtering_section.dart';
import 'widgets/search_mode_switcher.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _showSearchHistory() {
    context.read<SearchHistoryCubit>().loadHistory(
      keyword: _searchController.text,
    );
  }

  void _clearSearchHistory() {
    context.read<SearchHistoryCubit>().clear();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: customAppbar('البحث المتقدم'),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - 200) {
            context.read<AdvancedSearchCubit>().loadMore();
          }
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: GeneralSizes.medium,
              vertical: GeneralSizes.large,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    CustomTextField(
                      controller: _searchController,
                      onTap: _showSearchHistory,
                      onFieldSubmitted: (query) {
                        _clearSearchHistory();
                        context.read<AdvancedSearchCubit>().search(query);
                      },
                      hintText: 'ابحث عن حديث',
                      icon: HugeIcons.strokeRoundedSearch01,
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'إلغاء البحث',
                              onPressed: () {
                                _searchController.clear();
                                _clearSearchHistory();
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(Icons.close, color: AppColors.primary),
                            ),
                    ),
                    verticalMediumSpacing(),
                    SearchModeSwitcher(
                      selectedMode: context
                          .read<AdvancedSearchCubit>()
                          .searchMode,
                      onChanged: context
                          .read<AdvancedSearchCubit>()
                          .updateSearchMode,
                    ),
                    verticalMediumSpacing(),
                    BlocBuilder<AdvancedSearchCubit, AdvancedSearchStates>(
                      buildWhen: (previous, current) =>
                          current is AdvancedSearchLoading ||
                          current is AdvancedSearchFiltersLoaded ||
                          current is AdvancedSearchError,
                      builder: (context, state) {
                        final filters = context
                            .read<AdvancedSearchCubit>()
                            .filters;
                        if (filters == null && state is AdvancedSearchLoading) {
                          return CustomText(text: 'جاري تحميل الفلاتر ...');
                        }
                        if (filters == null && state is AdvancedSearchError) {
                          return CustomText(text: state.message);
                        }
                        if (filters == null) return const SizedBox.shrink();
                        return FilteringSection(
                          filters: filters,
                          onChanged: context
                              .read<AdvancedSearchCubit>()
                              .updateSelectedFilters,
                        );
                      },
                    ),
                    verticalLargeSpacing(),
                    BlocBuilder<AdvancedSearchCubit, AdvancedSearchStates>(
                      builder: (context, state) {
                        if (state is AdvancedSearchLoading) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: LottieBuilder.asset(
                                  Assets.assetsImagesLottiesLoadingCircle,
                                ),
                              ),
                              CustomText(
                                text: 'الرجاء الانتظار ...',
                                color: AppColors.primary,
                              ),
                            ],
                          );
                        } else if (state is AdvancedSearchSuccess ||
                            state is AdvancedSearchLoadingMore) {
                          final items = context
                              .read<AdvancedSearchCubit>()
                              .results;
                          if (items.isEmpty) {
                            return CustomText(text: 'لا توجد نتائج');
                          }
                          return Column(
                            children: [
                              ...items.map<Widget>((item) {
                                return HadithCard(items: item);
                              }),
                              if (state is AdvancedSearchLoadingMore)
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: LottieBuilder.asset(
                                    Assets.assetsImagesLottiesLoadingBlackDots,
                                  ),
                                ),
                            ],
                          );
                        } else if (state is AdvancedSearchError) {
                          return CustomText(text: state.message);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
                Positioned(
                  top: 58,
                  left: 0,
                  right: 0,
                  child: SearchHistoryList(
                    onSelected: (value) {
                      _searchController.text = value;
                      _searchController.selection = TextSelection.collapsed(
                        offset: value.length,
                      );
                      _clearSearchHistory();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

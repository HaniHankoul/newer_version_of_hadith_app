import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/widgets/custom_text_field.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text.dart';
import '../logic/advanced_search_cubit.dart';
import '../logic/advanced_search_states.dart';
import 'widgets/filtering_section.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});

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
            child: Column(
              children: [
                CustomTextField(
                  onFieldSubmitted: (query) {
                    context.read<AdvancedSearchCubit>().search(query);
                  },
                  hintText: 'ابحث عن حديث',
                  icon: HugeIcons.strokeRoundedSearch01,
                ),
                verticalMediumSpacing(),
                BlocBuilder<AdvancedSearchCubit, AdvancedSearchStates>(
                  buildWhen: (previous, current) =>
                      current is AdvancedSearchLoading ||
                      current is AdvancedSearchFiltersLoaded ||
                      current is AdvancedSearchError,
                  builder: (context, state) {
                    final filters = context.read<AdvancedSearchCubit>().filters;
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
                      final items = context.read<AdvancedSearchCubit>().results;
                      if (items.isEmpty) {
                        return CustomText(text: 'لا توجد نتائج');
                      }
                      return Column(
                        children: [
                          ...items.map<Card>((item) {
                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  GeneralSizes.small,
                                ),
                                child: CustomText(
                                  text: item.text ?? '',
                                  fontSize: 15,
                                ),
                              ),
                            );
                          }),
                          if (state is AdvancedSearchLoadingMore)
                            const Padding(
                              padding: EdgeInsets.all(GeneralSizes.medium),
                              child: CircularProgressIndicator(),
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
          ),
        ),
      ),
    );
  }
}

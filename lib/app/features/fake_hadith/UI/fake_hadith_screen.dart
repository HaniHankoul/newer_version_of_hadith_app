import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/custom_text_field.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';
import 'package:hugeicons/hugeicons.dart';

import '../logic/fake_hadtith_cubit.dart';
import '../logic/fake_hadith_state.dart';

class FakeHadithScreen extends StatelessWidget {
  const FakeHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: customAppbar('أحاديث منتشرة لا تصح'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: CustomTextField(
              onFieldSubmitted: (value) {
                context.read<FakeHadtithCubit>().searchFakeHadith(value);
              },
              hintText: 'ابحث عن حديث ',
              icon: HugeIcons.strokeRoundedSearch01,
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent - 200) {
                  context.read<FakeHadtithCubit>().loadMore();
                }
                return false;
              },
              child: BlocBuilder<FakeHadtithCubit, FakeHadithState>(
                builder: (context, state) {
                  if (state is FakeHadithLoadingState) {
                    return const LoadingCard();
                  }
                  if (state is FakeHadithErrorState) {
                    return ErrorCard(message: state.errorMessage);
                  }

                  final hadiths = switch (state) {
                    FakeHadithSuccessState(:final hadiths) => hadiths,
                    FakeHadithLoadingMoreState(:final hadiths) => hadiths,
                    _ => const [],
                  };
                  if (hadiths.isEmpty) {
                    return Center(child: CustomText(text: 'لا توجد نتائج'));
                  }

                  final loadingMore = state is FakeHadithLoadingMoreState;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: hadiths.length + (loadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == hadiths.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final hadith = hadiths[index];
                      return Card(
                        child: ListTile(
                          title: Text(hadith.text ?? 'لا يوجد نص للحديث'),
                          subtitle: Text(
                            hadith.ruling?.name ?? 'حديث منتشر لا يصح',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

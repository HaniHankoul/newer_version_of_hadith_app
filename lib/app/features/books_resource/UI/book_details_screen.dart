import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';
import 'package:hadith_app/app/features/home/data/models/search_model.dart'
    as search_model;
import 'package:lottie/lottie.dart';

import '../../../core/helper/assets.dart';
import '../../../core/widgets/hadith_card.dart';
import '../data/models/book_model.dart';
import '../data/models/book_response.dart' as book_model;
import '../logic/book_details_cubit.dart';
import '../logic/book_details_cubit_state.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: customAppbar(book.name ?? 'تفاصيل الكتاب'),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - 200) {
            context.read<BookDetailsCubit>().loadMore();
          }
          return false;
        },
        child: BlocBuilder<BookDetailsCubit, BookDetailsCubitState>(
          builder: (context, state) {
            if (state is BookDetailsLoading) return const LoadingCard();
            if (state is BookDetailsError) {
              return ErrorCard(message: 'حدث خطأ أثناء التحميل');
            }

            final hadiths = switch (state) {
              BookDetailsSuccess(:final hadiths) => hadiths,
              BookDetailsLoadingMore(:final hadiths) => hadiths,
              _ => const <book_model.Item>[],
            };
            if (hadiths.isEmpty) {
              return Center(child: CustomText(text: 'لا توجد أحاديث'));
            }

            final loadingMore = state is BookDetailsLoadingMore;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: hadiths.length + (loadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == hadiths.length) {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: LottieBuilder.asset(
                        Assets.assetsImagesLottiesLoadingBlackDots,
                      ),
                    ),
                  );
                }
                final hadith = hadiths[index];
                return HadithCard(items: _toSearchItem(hadith));
              },
            );
          },
        ),
      ),
    );
  }

  search_model.Item _toSearchItem(book_model.Item hadith) {
    return search_model.Item(
      id: hadith.id,
      text: hadith.text,
      normalText: hadith.normalText,
      hadithNumber: hadith.hadithNumber,
      sanad: hadith.sanad,
      book: _toSearchBook(hadith.book),
      rawi: _toSearchBook(hadith.rawi),
      ruling: _toSearchBook(hadith.ruling),
      muhaddith: _toSearchBook(hadith.muhaddith),
      topics: hadith.topics
          ?.map(_toSearchBook)
          .whereType<search_model.Book>()
          .toList(),
      hasExplanation: hadith.hasExplanation,
      hasSubValid: hadith.hasSubValid,
    );
  }

  search_model.Book? _toSearchBook(book_model.Book? book) {
    if (book == null) return null;
    return search_model.Book(id: book.id, name: book.name);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';

import '../data/models/book_model.dart';
import '../data/models/book_response.dart';
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
              return ErrorCard(message: state.message);
            }

            final hadiths = switch (state) {
              BookDetailsSuccess(:final hadiths) => hadiths,
              BookDetailsLoadingMore(:final hadiths) => hadiths,
              _ => const <Item>[],
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
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final hadith = hadiths[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomText(
                      text: hadith.text ?? 'لا يوجد نص للحديث',
                      fontSize: 17,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

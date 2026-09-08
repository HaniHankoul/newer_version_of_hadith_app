import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

import '../../../core/helper/general_sizes.dart';
import '../logic/book_cubit.dart';
import '../logic/book_cubit_state.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: customAppbar('الكتب و المصادر'),
      body: BlocBuilder<BookCubit, BookCubitState>(
        builder: (context, state) {
          if (state is BookCubitLoading) return const LoadingCard();
          if (state is BookCubitError) {
            return ErrorCard(message: 'حدث خطأ أثناء التحميل');
          }
          if (state is BookCubitSuccess) {
            if (state.books.isEmpty) {
              return Center(child: CustomText(text: 'لا توجد كتب'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return InkWell(
                  onTap: book.id == null
                      ? null
                      : () => context.push('/bookDetails', extra: book),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        UniversalContainer(
                              heightPortion: 0,
                              widthPortion: 1,
                              borderColor: AppColors.primary,
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  GeneralSizes.medium,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomText(
                                      text: book.name ?? 'حديث مفضل',
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    verticalSmallSpacing(),
                                    Text(
                                      textDirection: TextDirection.rtl,
                                      book.muhaddith?.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Cairo',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .animate(
                              delay: (index * 180).ms,
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true),
                            )
                            .moveY(
                              begin: -3,
                              end: 3,
                              duration: 2200.ms,
                              curve: Curves.easeInOut,
                            ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

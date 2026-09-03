import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';

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
          if (state is BookCubitError) return ErrorCard(message: state.message);
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
                  child: Card(
                    child: ListTile(
                      title: CustomText(
                        text: book.name ?? 'كتاب بدون اسم',
                        fontSize: 18,
                      ),
                      subtitle: book.muhaddith?.name == null
                          ? null
                          : CustomText(
                              text: book.muhaddith!.name!,
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
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

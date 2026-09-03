import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';
import 'package:hadith_app/app/core/widgets/translators_card.dart';

import '../../../../core/app_theme.dart';
import '../logic/muhaddith_cubit.dart';
import '../logic/muhaddith_state.dart';

class MuhaddithsScreen extends StatelessWidget {
  const MuhaddithsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: customAppbar('تراجم المحدثين'),
      body: BlocBuilder<MuhaddithCubit, MuhaddithState>(
        builder: (context, state) {
          if (state is MuhaddithLoading) return const LoadingCard();
          if (state is MuhaddithError) {
            return ErrorCard(message: state.message);
          }
          if (state is MuhaddithSuccess) {
            if (state.muhaddiths.isEmpty) {
              return Center(child: CustomText(text: 'لا توجد تراجم'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(GeneralSizes.large),
              itemCount: state.muhaddiths.length,
              itemBuilder: (context, index) {
                final muhaddith = state.muhaddiths[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: GeneralSizes.small,
                  ),
                  child: TranslatorsCard(
                    nameTitle: muhaddith.name ?? 'اسم المحدث غير متوفر',
                    cardText: muhaddith.about ?? 'لا توجد ترجمة متوفرة',
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

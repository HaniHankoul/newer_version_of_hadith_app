import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/error_card.dart';
import '../../../../core/widgets/loading_card.dart';
import '../../../../core/widgets/translators_card.dart';
import '../logic/rawi_cubit.dart';
import '../logic/rawi_state.dart';

class RawiScreen extends StatelessWidget {
  const RawiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: customAppbar('تراجم الرواة'),
      body: BlocBuilder<RawiCubit, RawiState>(
        builder: (context, state) {
          if (state is RawiLoading) return const LoadingCard();
          if (state is RawiError) return ErrorCard(message: state.message);
          if (state is RawiSuccess) {
            if (state.rawis.isEmpty) {
              return Center(child: CustomText(text: 'لا توجد رواة'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(GeneralSizes.large),
              itemCount: state.rawis.length,
              itemBuilder: (context, index) {
                final rawi = state.rawis[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: GeneralSizes.small,
                  ),
                  child: TranslatorsCard(
                    nameTitle: rawi.name ?? 'اسم الراوي غير متوفر',
                    cardText: rawi.about ?? 'لا توجد ترجمة متوفرة',
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

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';
import 'package:hadith_app/app/features/favourite/UI/widgets/favourite_card.dart';
import '../../../core/widgets/universal_button.dart';
import '../logic/favorite_cubit.dart';
import '../logic/favorit_cubit_states.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoritCubitStates>(
      builder: (context, state) {
        if (state is FavoriteCubitLoading) return const LoadingCard();
        if (state is FavoriteCubitError) {
          return Column(
            children: [
              ErrorCard(message: 'حدث خطأ أثناء التحميل'),
              UniversalButton(
                widthPortion: .4,
                borderColor: AppColors.primary,
                color: AppColors.primary,
                onTap: () => context.read<FavoriteCubit>().showFavorite(),
                title: 'إعادة المحاولة',
                textColor: Colors.black,
              ),
            ],
          );
        }
        if (state is FavoriteCubitSuccess) {
          final items = state.favoritModel.items ?? [];
          if (items.isEmpty) {
            return Center(child: CustomText(text: 'لا توجد أحاديث مفضلة'));
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(GeneralSizes.medium),
            itemCount: items.length,
            separatorBuilder: (_, _) => verticalSmallSpacing(),
            itemBuilder: (context, index) {
              final item = items[index];
              return FavouriteCard(item: item, index: index);
            },
          ).animate().fade(duration: 250.ms);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

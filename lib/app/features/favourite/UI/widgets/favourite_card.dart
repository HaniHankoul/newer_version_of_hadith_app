import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../data/models/favorite_model.dart';

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({super.key, required this.item, required this.index});
  final Item item;
  final int index;
  @override
  Widget build(BuildContext context) {
    return UniversalContainer(
          heightPortion: 0,
          widthPortion: 1,
          borderColor: AppColors.primary,
          child: InkWell(
            onTap: item.id == null
                ? null
                : () => context.push(
                    '/hadithDetail',
                    extra: {'title': 'الحديث المفضل', 'favoriteItem': item},
                  ),
            child: Padding(
              padding: const EdgeInsets.all(GeneralSizes.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: item.book?.name ?? 'حديث مفضل',
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  verticalSmallSpacing(),
                  Text(
                    textDirection: TextDirection.rtl,
                    item.text ?? 'لا يوجد نص للحديث',
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
          ),
        )
        .animate(
          delay: (index * 180).ms,
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .moveY(begin: -3, end: 3, duration: 2200.ms, curve: Curves.easeInOut);
  }
}

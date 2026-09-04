import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';

import '../../features/home/data/models/search_model.dart';
import '../app_theme.dart';
import 'custom_text.dart';

class HadithCard extends StatelessWidget {
  const HadithCard({super.key, required this.items});
  final Item items;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          if (items.id != null) {
            context.push('/hadithDetail', extra: items.id);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusM),
            border: Border.all(color: AppColors.primaryLight, width: 1),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(100),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: GeneralSizes.medium,
                  right: GeneralSizes.small,
                  left: GeneralSizes.small,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(GeneralSizes.small),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withAlpha(50),
                    borderRadius: BorderRadius.circular(borderRadiusM),
                    border: Border.all(color: AppColors.primary, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        items.text ?? '',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: GeneralSizes.hadithFontSize,
                        ),
                      ),
                      Text(
                        textDirection: TextDirection.rtl,
                        'عرض المزيد ... ',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'cairo',
                          fontSize: GeneralSizes.hadithFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: GeneralSizes.medium,
                  vertical: GeneralSizes.small,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: 'خلاصة حكم المحدث: ${items.ruling?.name ?? ' '}',
                      fontSize: 16,
                    ),
                    CustomText(
                      text: 'الراوي: ${items.rawi?.name ?? ' '}',
                      fontSize: 16,
                    ),
                    CustomText(
                      text: 'المحدث: ${items.muhaddith?.name ?? ' '}',
                      fontSize: 16,
                    ),
                    CustomText(
                      text: 'المصدر: ${items.book?.name ?? ' '}',
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

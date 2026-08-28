import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

import '../../features/home/data/models/search_model.dart';
import 'custom_text.dart';
import 'universal_button.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.title, required this.item});
  final String title;
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: customAppbar(title),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: GeneralSizes.large,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.88,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadiusM),
                      border: Border.all(
                        color: AppColors.primaryLight,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(100),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: GeneralSizes.medium,
                        vertical: GeneralSizes.medium,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: GeneralSizes.small,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  child: Icon(
                                    Icons.local_florist_outlined,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              horizontalSmallSpacing(),
                              CustomText(
                                text: 'بيانات الحديث',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: GeneralSizes.large,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    borderRadiusM,
                                  ),
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                                child: CustomText(
                                  text: item.book?.name ?? ' ',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              horizontalSmallSpacing(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: GeneralSizes.large,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    borderRadiusM,
                                  ),
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                                child: CustomText(
                                  text:
                                      'رقم الحديث: ${item.hadithNumber ?? ' '}',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          verticalMediumSpacing(),
                          UniversalContainer(
                            heightPortion: 0,
                            widthPortion: .84,
                            borderColor: AppColors.primary,
                            color: AppColors.primaryLight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                text: item.text ?? ' ',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          verticalMediumSpacing(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: item.ruling?.name ?? ' ',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 'خلاصة حكم المحدث : ',
                                color: AppColors.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          verticalSmallSpacing(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: item.ruling?.name ?? ' ',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 'الحكم النهائي : ',
                                color: AppColors.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          verticalSmallSpacing(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: item.rawi?.name ?? ' ',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 'الراوي : ',
                                color: AppColors.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          verticalSmallSpacing(),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  child: Icon(
                                    Icons.local_florist_outlined,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              CustomText(
                                text: 'التصنيف الموضوعي',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          UniversalContainer(
                            heightPortion: 0,
                            widthPortion: .84,
                            borderColor: AppColors.primary,
                            color: AppColors.primaryLight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CustomText(
                                  text:
                                      item.topics?.join(', ') ??
                                      'لا توجد موضوعات مرتبطة',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            verticalLargeSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UniversalButton(
                  widthPortion: .37,
                  icon: Icons.bookmark_added_sharp,
                  title: 'تعيين مفضلة',
                  onTap: () {},
                  color: AppColors.primary,
                  textColor: AppColors.white,
                  borderColor: AppColors.primary,
                ),
                horizontalLargeSpacing(),
                UniversalButton(
                  widthPortion: .37,
                  icon: Icons.copy,
                  title: 'نسخ',
                  onTap: () {},
                  color: AppColors.white,
                  textColor: AppColors.black,
                  borderColor: AppColors.primary,
                ),
              ],
            ),
            verticalLargeSpacing(),
          ],
        ),
      ),
    );
  }
}

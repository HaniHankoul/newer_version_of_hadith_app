import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

import 'custom_text.dart';
import 'universal_button.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.title});
  final String title;
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
                  child: UniversalContainer(
                    heightPortion: 0,
                    widthPortion: .88,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: GeneralSizes.medium,
                        vertical: GeneralSizes.large,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                                text: 'بيانات الحديث',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  text: 'اسم الكتاب',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              horizontalLargeSpacing(),
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
                                  text: 'رقم الحديث',
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
                                text:
                                'حَدَّثَنَا سَعِيدُ بْنُ مُحَمَّدٍ الْجَرْمِيُّ، حَدَّثَنَا يَعْقُوبُ بْنُ إِبْرَاهِيمَ، حَدَّثَنَا أَبِي، عَنْ صَالِحٍ، عَنِ ابْنِ عُبَيْدَةَ بْنِ نَشِيطٍ ـ وَكَانَ فِي مَوْضِعٍ آخَرَ اسْمُهُ عَبْدُ اللَّهِ ـ أَنَّ عُبَيْدَ اللَّهِ بْنَ عَبْدِ اللَّهِ بْنِ عُتْبَةَ قَالَ بَلَغَنَا أَنَّ مُسَيْلِمَةَ الْكَذَّابَ قَدِمَ الْمَدِينَةَ، فَنَزَلَ فِي دَارِ بِنْتِ الْحَارِثِ، وَكَانَ تَحْتَهُ بِنْتُ الْحَارِثِ بْنِ كُرَيْزٍ، وَهْىَ أُمُّ عَبْدِ اللَّهِ بْنِ عَامِرٍ، فَأَتَاهُ رَسُولُ اللَّهِ صلى الله عليه وسلم وَمَعَهُ ثَابِتُ بْنُ قَيْسِ بْنِ شَمَّاسٍ، وَهْوَ الَّذِي يُقَالُ لَهُ خَطِيبُ رَسُولِ اللَّهِ صلى الله عليه وسلم وَفِي يَدِ رَسُولِ اللَّهِ صلى الله عليه وسلم قَضِيبٌ، فَوَقَفَ عَلَيْهِ فَكَلَّمَهُ فَقَالَ لَهُ مُسَيْلِمَةُ إِنْ شِئْتَ خَلَّيْتَ بَيْنَنَا وَبَيْنَ الأَمْرِ، ثُمَّ جَعَلْتَهُ لَنَا . فَقَالَ النَّبِيُّ صلى الله عليه وسلم " لَوْ سَأَلْتَنِي هَذَا الْقَضِيبَ مَا',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          verticalMediumSpacing(),
                          CustomText(
                            text: 'خلاصة حكم المحدث ',
                            color: AppColors.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          verticalSmallSpacing(),
                          CustomText(
                            text: 'الحكم النهائي ',
                            color: AppColors.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          verticalSmallSpacing(),
                          CustomText(
                            text: 'الراوي ',
                            color: AppColors.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
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
                                  text: 'لا توجد موضوعات مرتبطة',
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

import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_container.dart';

class TodaysHadithHeader extends StatelessWidget {
  const TodaysHadithHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: GeneralSizes.medium,
        left: GeneralSizes.large,
        right: GeneralSizes.large,
      ),
      child: UniversalContainer(
        heightPortion: 0,
        widthPortion: MediaQuery.of(context).size.width * .84,
        borderColor: Colors.black38,
        color: AppColors.primaryRich,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: 'حديث اليوم',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              verticalSmallSpacing(),
              Text(
                textDirection: TextDirection.rtl,
                'حَدَّثَنَا سَعِيدُ بْنُ مُحَمَّدٍ الْجَرْمِيُّ، حَدَّثَنَا يَعْقُوبُ بْنُ إِبْرَاهِيمَ، حَدَّثَنَا أَبِي، عَنْ صَالِحٍ، عَنِ ابْنِ عُبَيْدَةَ بْنِ نَشِيطٍ ـ وَكَانَ فِي مَوْضِعٍ آخَرَ اسْمُهُ عَبْدُ اللَّهِ ـ أَنَّ عُبَيْدَ اللَّهِ بْنَ عَبْدِ اللَّهِ بْنِ عُتْبَةَ قَالَ بَلَغَنَا أَنَّ مُسَيْلِمَةَ الْكَذَّابَ قَدِمَ الْمَدِينَةَ، فَنَزَلَ فِي دَارِ بِنْتِ الْحَارِثِ، وَكَانَ تَحْتَهُ بِنْتُ الْحَارِثِ بْنِ كُرَيْزٍ، وَهْىَ أُمُّ عَبْدِ اللَّهِ بْنِ عَامِرٍ، فَأَتَاهُ رَسُولُ اللَّهِ صلى الله عليه وسلم وَمَعَهُ ثَابِتُ بْنُ قَيْسِ بْنِ شَمَّاسٍ، وَهْوَ الَّذِي يُقَالُ لَهُ خَطِيبُ رَسُولِ اللَّهِ صلى الله عليه وسلم وَفِي يَدِ رَسُولِ اللَّهِ صلى الله عليه وسلم قَضِيبٌ، فَوَقَفَ عَلَيْهِ فَكَلَّمَهُ فَقَالَ لَهُ مُسَيْلِمَةُ إِنْ شِئْتَ خَلَّيْتَ بَيْنَنَا وَبَيْنَ الأَمْرِ، ثُمَّ جَعَلْتَهُ لَنَا . فَقَالَ النَّبِيُّ صلى الله عليه وسلم " لَوْ سَأَلْتَنِي هَذَا الْقَضِيبَ مَا',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(fontSize: 14),
              ),
              UniversalButton(
                onTap: () {},
                title: 'تفاصيل',
                icon: Icons.arrow_forward,
                color: AppColors.primaryRich,
                textColor: AppColors.white,
                borderColor: AppColors.primaryRich,
                widthPortion: .25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

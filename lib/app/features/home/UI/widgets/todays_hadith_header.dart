import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';
import 'package:hadith_app/app/features/books_resource/logic/book_details_cubit.dart';
import 'package:hadith_app/app/features/books_resource/logic/book_details_cubit_state.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_container.dart';

class TodaysHadithHeader extends StatelessWidget {
  const TodaysHadithHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
          [
                Padding(
                  padding: const EdgeInsets.only(
                    top: GeneralSizes.small + 4,
                    bottom: GeneralSizes.medium,
                    left: GeneralSizes.large,
                    right: GeneralSizes.large,
                  ),
                  child: UniversalContainer(
                    heightPortion: 0.18,
                    widthPortion: MediaQuery.of(context).size.width * .84,
                    borderColor: Colors.black38,
                    color: AppColors.primaryRich,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          BlocBuilder<BookDetailsCubit, BookDetailsCubitState>(
                            builder: (context, state) {
                              final hadith = state is BookDetailsSuccess
                                  ? state.hadiths[2].text.toString()
                                  : " ";
                              if (state is BookDetailsLoading) {
                                return Center(
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: LottieBuilder.asset(
                                      Assets
                                          .assetsImagesLottiesLoadingBlackDots,
                                    ),
                                  ),
                                );
                              } else if (state is BookDetailsError) {
                                return Center(
                                  child: CustomText(
                                    text: 'حدث خطأ اثناء جلب الحديث',
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return Column(
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
                                    hadith,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),

                                  UniversalButton(
                                    onTap: () {
                                      context.push(
                                        '/hadithDetail',
                                        extra: state is BookDetailsSuccess
                                            ? state.hadiths[2].id
                                            : null,
                                      );
                                    },
                                    title: 'تفاصيل',
                                    icon: Icons.arrow_forward,
                                    color: AppColors.primaryRich,
                                    textColor: AppColors.white,
                                    borderColor: AppColors.primaryRich,
                                    widthPortion: .28,
                                  ),
                                ],
                              );
                            },
                          ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 35,
                  child: SvgPicture.asset(
                    Assets.assetsImagesPetik,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ]
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .moveY(
                begin: -3,
                end: 3,
                duration: 1.seconds,
                curve: Curves.easeInOut,
              ),
    );
  }
}

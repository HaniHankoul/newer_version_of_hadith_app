import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/universal_container.dart';

import '../hadith_detail/logic/hadith_detail_cubit.dart';
import '../hadith_detail/logic/hadith_detail_cubit_state.dart';
import '../helper/constants.dart';
import 'custom_text.dart';
import 'universal_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/favourite/logic/favorite_cubit.dart';
import '../../features/favourite/logic/favorit_cubit_states.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.hadithId});

  final String? hadithId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteCubit, FavoritCubitStates>(
      listener: (context, state) {
        if (state is FavoriteCubitAddSuccess) {
          Constants().detailsBar(
            state.added
                ? 'تمت إضافة الحديث إلى المفضلة'
                : 'الحديث موجود مسبقاً في المفضلة',
          );
        } else if (state is FavoriteCubitRemoveSuccess) {
          Constants().detailsBar('تمت إزالة الحديث من المفضلة');
        } else if (state is FavoriteCubitError) {
          Constants().detailsBar('سجل الدخول اولا');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: customAppbar('تفاصيل الحديث'),
        body: SizedBox(
          width: double.infinity,
          child: BlocBuilder<HadithDetailCubit, HadithDetailCubitState>(
            builder: (context, state) {
              if (state is HadithDetailLoading ||
                  state is HadithDetailInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HadithDetailError) {
                return Center(child: Text(state.message));
              }
              final hadith = state is HadithDetailSuccess ? state.hadith : null;
              if (hadith == null) return const SizedBox.shrink();
              return Column(
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
                                offset: Offset(
                                  0,
                                  2,
                                ), // changes position of shadow
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
                                        text: hadith.type ?? '',
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
                                            'رقم الحديث: ${hadith.hadithNumber ?? ''}',
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
                                  color: AppColors.primaryLight.withAlpha(50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      text: hadith.text?.toString() ?? '',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                verticalMediumSpacing(),
                                if (hadith.explanation != null)
                                  UniversalContainer(
                                    heightPortion: 0,
                                    widthPortion: .84,
                                    borderColor: AppColors.primary,
                                    color: AppColors.primaryLight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        text:
                                            hadith.explanation?.text
                                                .toString() ??
                                            '',
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
                                      text: hadith.ruling?.name ?? '',
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
                                      text:
                                          hadith.ruling?.name.toString() ?? '',
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
                                      text: hadith.rawi?.name ?? '',
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
                                        text: hadith.topics?.isNotEmpty == true
                                            ? hadith.topics!
                                                  .map((topic) => topic.name)
                                                  .join('، ')
                                            : 'لا توجد موضوعات مرتبطة',
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<FavoriteCubit, FavoritCubitStates>(
                          builder: (context, state) {
                            final favorite = state is FavoriteCubitAddSuccess
                                ? true
                                : state is FavoriteCubitRemoveSuccess
                                ? false
                                : state is FavoriteCubitSuccess &&
                                      hadithId != null
                                ? state.favoritModel.items?.any(
                                        (item) => item.id == hadithId,
                                      ) ??
                                      false
                                : false;
                            final loading =
                                state is FavoriteCubitAdding ||
                                state is FavoriteCubitLoading;

                            return UniversalButton(
                              widthPortion: .4,
                              icon: favorite
                                  ? Icons.bookmark_remove_outlined
                                  : Icons.bookmark_added_sharp,
                              title: favorite
                                  ? 'إزالة من المفضلة'
                                  : 'تعيين مفضلة',
                              isLoading: loading,
                              onTap: () {
                                if (hadithId == null || hadithId!.isEmpty) {
                                  return;
                                }
                                if (favorite) {
                                  context.read<FavoriteCubit>().removeFavorite(
                                    hadithId!,
                                  );
                                } else {
                                  context.read<FavoriteCubit>().addFavorite(
                                    hadithId!,
                                  );
                                }
                              },
                              color: AppColors.primary,
                              textColor: AppColors.white,
                              borderColor: AppColors.primary,
                            );
                          },
                        ),
                        horizontalLargeSpacing(),
                        UniversalButton(
                          widthPortion: .35,
                          icon: Icons.copy,
                          title: 'نسخ',
                          onTap: () => _copyHadith(context, hadith.text),
                          color: AppColors.white,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                        ),
                        horizontalLargeSpacing(),
                        UniversalButton(
                          widthPortion: .35,
                          icon: Icons.share_outlined,
                          title: 'مشاركة',
                          onTap: () => _shareHadith(context, hadith.text),
                          color: AppColors.white,
                          textColor: AppColors.black,
                          borderColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  verticalLargeSpacing(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _copyHadith(BuildContext context, String? text) async {
    final hadithText = text?.trim() ?? '';
    if (hadithText.isEmpty) return;

    await Clipboard.setData(ClipboardData(text: hadithText));
    if (!context.mounted) return;
    Constants().detailsBar('تم نسخ نص الحديث إلى الحافظة');
  }

  Future<void> _shareHadith(BuildContext context, String? text) async {
    final hadithText = text?.trim() ?? '';
    if (hadithText.isEmpty) return;

    try {
      await SharePlus.instance.share(ShareParams(text: hadithText));
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: hadithText));
      if (!context.mounted) return;
      Constants().detailsBar(
        'تعذر مشاركة الحديث، تم نسخ نص الحديث إلى الحافظة',
      );
    }
  }
}

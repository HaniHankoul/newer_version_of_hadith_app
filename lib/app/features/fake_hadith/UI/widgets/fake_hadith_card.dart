import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/font_size/logic/font_size_cubit.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_container.dart';
import '../../data/model/fake_hadith_response.dart';

class FakeHadithCard extends StatelessWidget {
  const FakeHadithCard({
    super.key,
    required this.item,
    this.showFullText = false,
  });

  final FakeHadithResponse item;
  final bool showFullText;

  @override
  Widget build(BuildContext context) {
    final hadithFontSize = context.watch<FontSizeCubit>().state.fontSize;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
              offset: const Offset(0, 2),
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
              child: InkWell(
                onTap: () {
                  context.push(
                    '/fakeHadithAlert/${item.id}',
                    extra: {'hadithId': item.id},
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(GeneralSizes.small),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withAlpha(50),
                    borderRadius: BorderRadius.circular(borderRadiusM),
                    border: Border.all(color: AppColors.primary, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.text ?? '',
                        textDirection: TextDirection.rtl,
                        maxLines: showFullText ? null : 5,
                        overflow: showFullText
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: hadithFontSize,
                        ),
                      ),
                    ],
                  ),
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
                    text: 'الحكم : ${item.ruling?.name ?? ' '}',
                    fontSize: 16,
                  ),

                  if (item.subValid?.normalText != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(text: 'الصحيح البديل:', fontSize: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: GeneralSizes.small,
                          ),
                          child: InkWell(
                            onTap: () {
                              context.push(
                                '/hadithDetail',
                                extra: {'hadithId': item.subValid?.id},
                              );
                            },
                            child: UniversalContainer(
                              heightPortion: 0,
                              widthPortion: .84,
                              borderColor: AppColors.primary,
                              color: AppColors.primaryLight.withAlpha(50),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  text:
                                      item.subValid?.normalText?.toString() ??
                                      '',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/helper/constants.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';
import '../../logic/avatar/avatar_state.dart';
import '../../logic/avatar/avatar_cubit.dart';
import 'picture_bottom_sheet_body.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvatarCubit, AvatarState>(
      listener: (context, state) {
        if (state is AvatarError) {
          Constants().errorBar('جرب اختيار صورة بحجم اقل من 2 ميجابايت');
        }
      },
      builder: (context, state) {
        final currentAvatarUrl = state is AvatarDeleted
            ? null
            : state is AvatarSuccess
            ? state.model.avatarUrl
            : avatarUrl;
        final isProcessing = state is AvatarLoading;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: GeneralSizes.small),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: AppColors.white),
                    ),
                  ),
                  CustomText(
                    text: 'بيانات الملف الشخصي',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            Center(
              child: isProcessing
                  ? CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.black.withAlpha(200),
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : CircleAvatar(
                      backgroundColor: AppColors.black.withAlpha(200),
                      radius: 50,
                      backgroundImage: currentAvatarUrl == null
                          ? null
                          : NetworkImage(currentAvatarUrl),
                      child: currentAvatarUrl == null
                          ? HugeIcon(
                              icon: HugeIcons.strokeRoundedMale02,
                              size: 60,
                              color: AppColors.white,
                            )
                          : null,
                    ),
            ),
            verticalMediumSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UniversalButton(
                  icon: Icons.delete,
                  title: 'ازالة الصورة',
                  onTap: isProcessing
                      ? () {}
                      : () => context.read<AvatarCubit>().deleteAvatar(),
                  color: AppColors.white,
                  textColor: AppColors.black,
                  borderColor: AppColors.primary,
                ),
                horizontalLargeSpacing(),
                horizontalMediumSpacing(),

                UniversalButton(
                  icon: Icons.photo,
                  title: 'تعيين صورة',
                  onTap: isProcessing
                      ? () {}
                      : () {
                          final avatarCubit = context.read<AvatarCubit>();
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            builder: (context) => PictureBottomSheetBody(
                              onImageSelected: (image) {
                                avatarCubit.updateAvatar(image);
                              },
                            ),
                          );
                        },
                  color: AppColors.primary,
                  textColor: AppColors.white,
                  borderColor: AppColors.primary,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

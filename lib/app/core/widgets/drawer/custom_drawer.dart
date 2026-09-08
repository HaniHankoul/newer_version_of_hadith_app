import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';

import '../../app_theme.dart';
import '../../helper/assets.dart';
import '../../helper/general_sizes.dart';
import '../../navigation/logic/navigation_cubit.dart';
import '../../../features/profile/logic/profile/profile_cubit.dart';
import '../../../features/profile/logic/profile/profile_cubit_state.dart';
import '../custom_text.dart';
import 'drawer_button.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
      child: Drawer(
        width: MediaQuery.of(context).size.width * .65,
        backgroundColor: AppColors.primaryLight,
        child: SafeArea(
          child: Column(
            children: [
              const _ProfileDrawerHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomDrawerButton(
                        onTap: () {
                          context.push('/advancedSearch');
                        },
                        title: 'البحث المتقدم ',
                        icon: HugeIcons.strokeRoundedSearch02,
                      ),
                      CustomDrawerButton(
                        onTap: () {
                          context.push('/books');
                        },
                        title: 'الكتب و المصادر ',
                        icon: HugeIcons.strokeRoundedBookOpen01,
                      ),
                      CustomDrawerButton(
                        onTap: () {
                          context.read<NavigationCubit>().navigate(
                            NavigationState.favourites,
                          );
                          context.pop(context);
                        },
                        title: 'قائمة المفضلة ',
                        icon: HugeIcons.strokeRoundedFavourite,
                      ),
                      CustomDrawerButton(
                        onTap: () {
                          context.read<NavigationCubit>().navigate(
                            NavigationState.questions,
                          );
                          context.pop(context);
                        },
                        title: 'قائمة الاسئلة ',
                        icon: HugeIcons.strokeRoundedUserQuestion02,
                      ),
                      BlocBuilder<ProfileCubit, ProfileCubitState>(
                        builder: (context, state) {
                          if (state is! ProfileCubitSuccess) {
                            return const SizedBox.shrink();
                          }

                          final userType = state.profileResponse?.type
                              ?.toLowerCase();

                          if (userType == 'admin') {
                            return const SizedBox.shrink();
                          }

                          return CustomDrawerButton(
                            onTap: () {
                              context.push('/upgradeRequestScreen');
                            },
                            title: 'طلب الترقية ',
                            icon: HugeIcons.strokeRoundedFileQuestionMark,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              verticalMediumSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileDrawerHeader extends StatelessWidget {
  const _ProfileDrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GeneralSizes.medium,
        vertical: GeneralSizes.large,
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: GeneralSizes.small),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(GeneralSizes.medium),
        ),
        child: BlocBuilder<ProfileCubit, ProfileCubitState>(
          builder: (context, state) {
            if (state is ProfileCubitSuccess) {
              final profile = state.profileResponse;
              return Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primaryLight.withAlpha(500),
                        backgroundImage: profile?.avatarUrl == null
                            ? null
                            : NetworkImage(profile!.avatarUrl!),
                        child: profile?.avatarUrl == null
                            ? Icon(Icons.person, color: AppColors.primary)
                            : null,
                      ),
                      title: CustomText(
                        text: profile?.name ?? 'بدون اسم',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: CustomText(
                        text: profile?.email ?? 'بدون بريد إلكتروني',
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _profileButton(context),
                ],
              );
            }

            if (state is ProfileCubitLoading) {
              return Padding(
                padding: EdgeInsets.all(GeneralSizes.medium),
                child: SizedBox(
                  height: 70,
                  child: LottieBuilder.asset(
                    Assets.assetsImagesLottiesLoadingBlackDots,
                    width: 50,
                  ),
                ),
              );
            }

            return InkWell(
              onTap: () => context.push('/signUp'),
              child: Padding(
                padding: const EdgeInsets.all(GeneralSizes.small),
                child:
                    state is ProfileCubitError &&
                        state.errorMessage.contains('token')
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LottieBuilder.asset(
                            Assets.assetsImagesLottiesIcons8Key,
                            width: 30,
                          ),

                          CustomText(
                            text: 'سجل الآن لإنشاء حساب',
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ],
                      )
                    : Center(child: CustomText(text: 'حدث خطأ ما')),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _profileButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<NavigationCubit>().navigate(NavigationState.profile);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: GeneralSizes.medium,
          vertical: GeneralSizes.small / 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GeneralSizes.large),
          border: Border.all(color: AppColors.primary),
        ),
        child: CustomText(
          text: 'تعديل الملف الشخصي',
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

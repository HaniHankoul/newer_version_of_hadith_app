import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_theme.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/error_card.dart';
import '../../../core/widgets/loading_card.dart';
import '../../../core/widgets/universal_button.dart';
import '../../../core/widgets/universal_container.dart';
import '../data/models/profile_response_model.dart';
import '../logic/profile/profile_cubit.dart';
import '../logic/profile/profile_cubit_state.dart';
import 'widgets/profile_form_info.dart';
import 'widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final birthDateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  void _setControllers(ProfileResponse profile) {
    if (nameController.text.isEmpty) nameController.text = profile.name ?? '';
    if (genderController.text.isEmpty) {
      genderController.text = profile.gender ?? '';
    }
    if (birthDateController.text.isEmpty && profile.birthDate != null) {
      final date = profile.birthDate!;
      birthDateController.text =
          '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _pickBirthDate() async {
    final today = DateTime.now();
    final latestBirthDate = DateTime(today.year - 6, today.month, today.day);
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: latestBirthDate,
      initialDate: _validInitialBirthDate(latestBirthDate),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.textWhite,
            surface: AppColors.primaryLight,
            onSurface: AppColors.textPrimary,
          ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: AppColors.primaryLight,
            headerBackgroundColor: AppColors.primary,
            headerForegroundColor: AppColors.textWhite,
          ),
        ),
        child: child!,
      ),
    );
    if (selected != null) {
      birthDateController.text =
          '${selected.year.toString().padLeft(4, '0')}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}';
    }
  }

  DateTime _validInitialBirthDate(DateTime latestBirthDate) {
    final currentDate = DateTime.tryParse(birthDateController.text);
    if (currentDate == null || currentDate.isAfter(latestBirthDate)) {
      return latestBirthDate;
    }
    return currentDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileCubitState>(
      builder: (context, state) {
        if (state is ProfileCubitLoading) {
          return LoadingCard();
        }

        if (state is ProfileCubitError) {
          return ErrorCard(message: 'عذرا حدث خطا ما');
        }
        if (state is ProfileCubitSuccess || state is ProfileCubitUpdating) {
          final profile = state is ProfileCubitSuccess
              ? state.profileResponse
              : (state as ProfileCubitUpdating).profileResponse;
          if (profile != null) _setControllers(profile);
          return Padding(
            padding: const EdgeInsets.only(top: GeneralSizes.large + 8),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children:
                    [
                          UniversalContainer(
                            heightPortion: 0,
                            widthPortion: .85,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ProfileHeader(avatarUrl: profile?.avatarUrl),
                                verticalLargeSpacing(),
                                ProfileFormInfo(
                                  state: ProfileCubitSuccess(
                                    profileResponse: profile,
                                  ),
                                  nameController: nameController,
                                  genderController: genderController,
                                  birthDateController: birthDateController,
                                  onBirthDateTap: _pickBirthDate,
                                ),
                              ],
                            ),
                          ),
                          verticalLargeSpacing(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: GeneralSizes.large,
                            ),
                            child: UniversalButton(
                              onTap: () {
                                if (profile != null) {
                                  context.read<ProfileCubit>().updateProfile(
                                    name: nameController.text,
                                    gender: genderController.text,
                                    birthDate: birthDateController.text,
                                  );
                                }
                              },
                              height: 45,
                              title: 'حفظ التغييرات في الملف الشخصي',
                              color: AppColors.primaryRich,
                              textColor: Colors.black,
                              borderColor: AppColors.primaryRich,
                              icon: Icons.person_3_outlined,
                              isLoading: state is ProfileCubitUpdating,
                            ),
                          ),
                        ]
                        .animate(interval: 100.ms)
                        .fade(duration: 250.ms)
                        .slide(begin: Offset(0, 0.3), duration: 200.ms),
              ),
            ),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Center(
            child: CustomText(
              text: 'سجل الدخول للوصول إلى الملف الشخصي',
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}

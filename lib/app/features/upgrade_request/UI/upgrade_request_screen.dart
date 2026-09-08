import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hadith_app/app/core/app_theme.dart';
import 'package:hadith_app/app/core/helper/constants.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/error_card.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';

import 'package:hadith_app/app/features/profile/logic/profile/profile_cubit.dart';
import 'package:hadith_app/app/features/profile/logic/profile/profile_cubit_state.dart';

import 'package:hadith_app/app/features/upgrade_request/UI/widgets/info_header.dart';
import 'package:hadith_app/app/features/upgrade_request/UI/widgets/send_bottom_sheet.dart';
import 'package:hadith_app/app/features/upgrade_request/UI/widgets/stalled_requests.dart';
import 'package:hadith_app/app/features/upgrade_request/logic/upgrade_cubit.dart';
import 'package:hadith_app/app/features/upgrade_request/logic/upgrade_state.dart';

class UpgradeRequestScreen extends StatelessWidget {
  const UpgradeRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: customAppbar('طلب الترقية'),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<ProfileCubit, ProfileCubitState>(
            builder: (context, profileState) {
              if (profileState is ProfileCubitLoading) {
                return const LoadingCard();
              }

              if (profileState is ProfileCubitError) {
                return const ErrorCard(
                  message: 'حدث خطأ أثناء تحميل بيانات الحساب',
                );
              }

              if (profileState is ProfileCubitSuccess) {
                final userType = profileState.profileResponse?.type
                    ?.toLowerCase();

                if (userType == 'scholar') {
                  return const _ScholarUpgradeSuccess();
                }

                if (userType == 'admin') {
                  return const _AdminView();
                }

                return const _MemberUpgradeContent();
              }

              return const LoadingCard();
            },
          ),
        ),
      ),
    );
  }
}

class _MemberUpgradeContent extends StatelessWidget {
  const _MemberUpgradeContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpgradeCubit, UpgradeState>(
      listener: (context, state) {
        if (state is UpgradeSubmitSuccess) {
          Constants().successBar('تم إرسال الطلب بنجاح');
        } else if (state is UpgradeFailure) {
          Constants().errorBar(state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is UpgradeLoading) {
          return const LoadingCard();
        }

        if (state is UpgradeFailure && state.request == null) {
          return const ErrorCard(message: 'حدث خطأ أثناء تحميل طلب الترقية');
        }

        final request = switch (state) {
          UpgradeLoaded() => state.request,
          UpgradeSubmitting() => state.request,
          UpgradeSubmitSuccess() => state.request,
          UpgradeFailure() => state.request,
          _ => null,
        };

        final isSubmitting = state is UpgradeSubmitting;

        final hasOpenRequest =
            request?.status == 'under_review' ||
            request?.status == 'pending_documents';

        final isApproved = request?.status == 'approved';

        final canSubmit = request == null || request.status == 'rejected';

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 22),

              const InfoHeader(),

              const SizedBox(height: 22),

              StalledRequests(request: request, isLoading: isSubmitting),

              if (hasOpenRequest) ...[
                const SizedBox(height: 20),
                _InfoMessage(
                  icon: Icons.schedule_rounded,
                  message:
                      'طلبك قيد المراجعة حالياً، وسيتم إشعارك عند اتخاذ القرار.',
                ),
              ],

              if (isApproved) ...[
                const SizedBox(height: 20),
                const _InfoMessage(
                  icon: Icons.check_circle_rounded,
                  message: 'تم قبول طلب الترقية بنجاح.',
                  success: true,
                ),
              ],

              if (canSubmit) ...[
                const SizedBox(height: 26),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            sendBottomSheet(context);
                          },
                    icon: const Icon(Icons.upload_file_rounded),
                    label: Text(
                      request?.status == 'rejected'
                          ? 'إرسال طلب جديد'
                          : 'إرسال طلب الترقية',
                      style: const TextStyle(fontFamily: 'cairo', fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 18),
            ],
          ),
        );
      },
    );
  }
}

class _ScholarUpgradeSuccess extends StatelessWidget {
  const _ScholarUpgradeSuccess();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.green.withAlpha(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 62,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'لقد تم الموافقة على ترقيتك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                'الآن يمكنك التعليق والإجابة على أسئلة الأعضاء.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 16,
                  height: 1.8,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminView extends StatelessWidget {
  const _AdminView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: 'هذه الصفحة مخصصة للأعضاء',
        color: AppColors.textSecondary,
        fontSize: 16,
      ),
    );
  }
}

class _InfoMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  final bool success;

  const _InfoMessage({
    required this.icon,
    required this.message,
    this.success = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: success
            ? Colors.green.withAlpha(15)
            : Colors.orange.withAlpha(15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: success ? Colors.green : Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 14,
                height: 1.7,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

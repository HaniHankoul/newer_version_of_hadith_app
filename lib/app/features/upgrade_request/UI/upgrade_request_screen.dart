import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/features/upgrade_request/UI/widgets/send_bottom_sheet.dart';
import '../data/models/upgrade_model_response.dart';
import '../logic/upgrade_cubit.dart';
import '../logic/upgrade_state.dart';

import '../../../core/app_theme.dart';
import '../../../core/widgets/custom_appbar.dart';
import 'widgets/info_header.dart';
import 'widgets/stalled_requests.dart';

class UpgradeRequestScreen extends StatelessWidget {
  const UpgradeRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpgradeCubit, UpgradeState>(
      listener: (context, state) {
        if (state is UpgradeSubmitSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('تم إرسال الطلب بنجاح')));
        } else if (state is UpgradeFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        final requests = state is UpgradeLoaded
            ? state.requests
            : state is UpgradeFailure
            ? state.requests
            : <UpgradeModelResponse>[];
        return Scaffold(
          backgroundColor: AppColors.primaryLight,
          appBar: customAppbar('طلب الترقية'),
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ?state is UpgradeCurrentLoaded
                        ? CustomText(text: state.request.status.toString())
                        : null,
                    const SizedBox(height: 22),
                    InfoHeader(),
                    const SizedBox(height: 22),
                    StalledRequests(
                      requests: requests,
                      isLoading: state is UpgradeLoading,
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          sendBottomSheet(context);
                        },
                        icon: const Icon(Icons.upload_file_rounded),
                        label: const Text(
                          'إرسال ملف',
                          style: TextStyle(fontFamily: 'cairo', fontSize: 18),
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
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

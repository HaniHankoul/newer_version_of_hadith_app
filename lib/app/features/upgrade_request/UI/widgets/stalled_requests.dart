import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../data/models/upgrade_model_response.dart';

class StalledRequests extends StatelessWidget {
  final UpgradeModelResponse requests;
  final bool isLoading;

  const StalledRequests({
    super.key,
    required this.requests,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withAlpha(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pending_actions_rounded, color: AppColors.primary),
              const SizedBox(width: 8),
              CustomText(
                text: 'الطلب الحالي',
                color: AppColors.textPrimaryDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 14),

          if (isLoading)
            Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: LottieBuilder.asset(
                  Assets.assetsImagesLottiesLoadingBlackDots,
                ),
              ),
            )
          else if (requests.id == "")
            Text(
              'لا توجد طلبات حالياً',
              style: TextStyle(
                fontFamily: 'cairo',
                color: AppColors.textSecondary,
              ),
            )
          else
            _requestCard(requests),
        ],
      ),
    );
  }

  Widget _requestCard(UpgradeModelResponse request) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            request.status == 'approved'
                ? Icons.check
                : request.status == 'rejected'
                ? Icons.close
                : Icons.schedule_rounded,
            color: request.status == 'approved'
                ? Colors.green
                : request.status == 'rejected'
                ? Colors.red
                : Colors.orange,
          ),

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.documentOriginalName ?? 'ملف الترقية',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ' الحالة : ${request.status}' ?? 'قيد المراجعة',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  request.notes == null || request.notes!.isEmpty
                      ? ''
                      : ' ملاحظات : ${request.notes}',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

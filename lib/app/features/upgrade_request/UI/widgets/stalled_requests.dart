import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../data/models/upgrade_model_response.dart';

class StalledRequests extends StatelessWidget {
  final List<UpgradeModelResponse> requests;
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
                text: 'الطلبات المعلقة',
                color: AppColors.textPrimaryDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 14),

          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (requests.isEmpty)
            Text(
              'لا توجد طلبات معلقة حالياً',
              style: TextStyle(
                fontFamily: 'cairo',
                color: AppColors.textSecondary,
              ),
            )
          else
            ...requests.map(_requestCard),
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
          Icon(Icons.schedule_rounded, color: AppColors.warning),
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
                  request.status ?? 'قيد المراجعة',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  request.notes == null || request.notes!.isEmpty
                      ? ''
                      : ' - ${request.notes}',
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

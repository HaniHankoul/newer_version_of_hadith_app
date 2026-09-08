import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../data/models/upgrade_model_response.dart';

class StalledRequests extends StatelessWidget {
  final UpgradeModelResponse? request;
  final bool isLoading;

  const StalledRequests({
    super.key,
    required this.request,
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
          else if (request == null)
            Text(
              'لا يوجد طلب ترقية حالياً',
              style: TextStyle(
                fontFamily: 'cairo',
                color: AppColors.textSecondary,
              ),
            )
          else
            _requestCard(request!),
        ],
      ),
    );
  }

  Widget _requestCard(UpgradeModelResponse request) {
    final statusText = _translateStatus(request.status);

    final statusColor = _statusColor(request.status);

    final statusIcon = _statusIcon(request.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(statusIcon, color: statusColor),

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

                const SizedBox(height: 6),

                Text(
                  'الحالة: $statusText',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),

                if (request.notes != null &&
                    request.notes!.trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'ملاحظاتك: ${request.notes}',
                    style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],

                if (request.reviewNotes != null &&
                    request.reviewNotes.toString().trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'ملاحظات المراجعة: ${request.reviewNotes}',
                    style: TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],

                if (request.status == 'rejected' &&
                    request.rejectionReason != null &&
                    request.rejectionReason.toString().trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'سبب الرفض: ${request.rejectionReason}',
                    style: const TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 13,
                      color: Colors.red,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _translateStatus(String? status) {
    switch (status) {
      case 'pending_documents':
        return 'بانتظار المستندات';

      case 'under_review':
        return 'قيد المراجعة';

      case 'approved':
        return 'تمت الموافقة';

      case 'rejected':
        return 'مرفوض';

      default:
        return 'غير معروف';
    }
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'approved':
        return Colors.green;

      case 'rejected':
        return Colors.red;

      case 'pending_documents':
      case 'under_review':
        return Colors.orange;

      default:
        return AppColors.textSecondary;
    }
  }

  IconData _statusIcon(String? status) {
    switch (status) {
      case 'approved':
        return Icons.check_circle_rounded;

      case 'rejected':
        return Icons.cancel_rounded;

      case 'pending_documents':
      case 'under_review':
        return Icons.schedule_rounded;

      default:
        return Icons.help_outline_rounded;
    }
  }
}

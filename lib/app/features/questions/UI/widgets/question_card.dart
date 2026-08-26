import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';
import '../../../../core/widgets/universal_container.dart';
import '../../data/models/questions_model_response.dart';
import '../../data/repo/questions_repo.dart';
import '../../logic/questions_cubit.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question, required this.index});

  final QuestionModelResponse question;
  final int index;

  Future<void> _deleteQuestion(BuildContext context) async {
    final questionId = question.id;

    if (questionId == null || questionId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد معرف للسؤال'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.primaryLight,
        title: CustomText(
          text: 'تأكيد الحذف',
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        content: CustomText(
          text: 'هل أنت متأكد من حذف هذا السؤال؟',
          fontSize: 13,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: CustomText(
              text: 'إلغاء',
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          UniversalButton(
            widthPortion: .2,
            onTap: () => Navigator.pop(dialogContext, true),
            title: 'حذف',
            color: AppColors.primary,
            textColor: Colors.black,
            borderColor: AppColors.primary,
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await QuestionsRepo().deleteQuestion(questionId);

      if (!context.mounted) return;

      context.read<QuestionsCubit>().getQuestions();

      Constants().successBar('تم حذف السؤال');
    } catch (e) {
      if (!context.mounted) return;

      Constants().errorBar('حدث خطأ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return UniversalContainer(
      borderColor: Colors.white,
      heightPortion: 0,
      widthPortion: .9,
      child: Padding(
        padding: const EdgeInsets.all(GeneralSizes.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UniversalButton(
                  onTap: () => _deleteQuestion(context),
                  title: 'حذف',
                  color: AppColors.primaryRich,
                  textColor: Colors.black,
                  borderColor: AppColors.primaryRich,
                  icon: Icons.delete_outline,
                  widthPortion: .25,
                ),
                CustomText(
                  text: 'السؤال ${index + 1} :',
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            CustomText(text: question.createdAt.toString(), fontSize: 13),
            verticalMediumSpacing(),
            CustomText(
              text: 'نص السؤال :',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            verticalSmallSpacing(),
            CustomText(
              text: question.askerText.toString(),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            verticalMediumSpacing(),
            CustomText(
              text: 'نص الجواب : ',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            verticalSmallSpacing(),
            CustomText(
              text: question.answerText ?? 'لم يتم الاجابة على سؤالك بعد ',
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}

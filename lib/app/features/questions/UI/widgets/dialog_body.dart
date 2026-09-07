import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../../../../core/helper/constants.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';
import '../../logic/questions_msg_cubit.dart';
import '../../logic/questions_states.dart';

class DialogBody extends StatefulWidget {
  const DialogBody({super.key});

  @override
  State<DialogBody> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: AppColors.primaryLight,
      title: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedQuillWrite01,
                    color: Colors.white,
                  ),
                ),
              ),
              CustomText(
                text: 'اطرح سؤالك هنا',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ],
          ),
          CustomText(
            text: 'اكتب سؤالك بوضوح ليتمكن المختص من الاجابة عليه بشكل ادق',
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
      content: TextFormField(
        controller: _controller,
        textDirection: TextDirection.rtl,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'اكتب سؤالك',
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: AppColors.primary,
            fontFamily: 'cairo',
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusM),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusM),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadiusM),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      actions: [
        BlocConsumer<QuestionsMsgCubit, QuestionsMessageStates>(
          listener: (context, state) {
            if (state is QuestionsMessageSuccessState) {
              Navigator.of(context).pop();
              _controller.clear();
              Constants().successBar('تم ارسال سؤالك بنجاح');
            }
            if (state is QuestionsMessageErrorState) {
              Constants().errorBar('حدث خطأ أثناء ارسال سؤالك');
            }
          },
          builder: (context, state) {
            if (state is QuestionsMessageLoadingState) {
              return LottieBuilder.asset(
                width: 50,
                height: 50,
                Assets.assetsImagesLottiesLoadingBlackDots,
              );
            }
            return UniversalButton(
              onTap: () => context.read<QuestionsMsgCubit>().sendMessage(
                context,
                _controller.text.trim(),
              ),
              title: 'إرسال',
              color: AppColors.primaryRich,
              textColor: Colors.white,
              borderColor: AppColors.primaryRich,
              icon: Icons.send,
              widthPortion: .3,
            );
          },
        ),
      ],
    );
  }
}

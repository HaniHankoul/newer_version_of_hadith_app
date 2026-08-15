import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/general_sizes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/universal_button.dart';
import '../../data/repo/questions_repo.dart';
import '../../logic/questions_cubit.dart';

class DialogBody extends StatefulWidget {
  const DialogBody({super.key});

  @override
  State<DialogBody> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _message;

  Future<void> _sendQuestion() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _message = null;
    });

    try {
      await QuestionsRepo().sendMessage(text);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _message = 'تم ارسال سؤالك بنجاح';
        context.read<QuestionsCubit>().getQuestions();
      });
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم ارسال سؤالك بنجاح'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _message = e.toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_message ?? 'حدث خطأ'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                  child: Icon(Icons.list, color: AppColors.white),
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
          contentPadding: EdgeInsets.zero,
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
        _isLoading
            ? const CircularProgressIndicator()
            : UniversalButton(
                onTap: _sendQuestion,
                title: 'إرسال',
                color: AppColors.primaryRich,
                textColor: Colors.black,
                borderColor: AppColors.primaryRich,
                icon: Icons.send,
                widthPortion: .3,
              ),
      ],
    );
  }
}

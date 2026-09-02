import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../logic/upgrade_cubit.dart';
import '../../logic/upgrade_state.dart';

void sendBottomSheet(BuildContext context) {
  final upgradeCubit = context.read<UpgradeCubit>();
  TextEditingController noteController = TextEditingController();
  PlatformFile? selectedFile;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (bottomSheetContext) {
      return BlocProvider.value(
        value: upgradeCubit,
        child: BlocListener<UpgradeCubit, UpgradeState>(
          listener: (context, state) {
            if (state is UpgradeSubmitSuccess) Navigator.of(context).pop();
          },
          child: StatefulBuilder(
            builder: (context, setSheetState) {
              final isSubmitting =
                  context.watch<UpgradeCubit>().state is UpgradeSubmitting;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 52,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Align(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: 'إرسال الملف',
                            color: AppColors.textPrimaryDark,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: isSubmitting
                                ? null
                                : () async {
                                    final result = await FilePicker.pickFile(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf'],
                                    );
                                    if (result != null && result.path != null) {
                                      setSheetState(
                                        () => selectedFile = result,
                                      );
                                    }
                                  },
                            icon: const Icon(Icons.attach_file_rounded),
                            label: Text(
                              selectedFile?.name ?? 'اختر الملف',
                              style: const TextStyle(fontFamily: 'cairo'),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          'ملاحظة',
                          style: TextStyle(
                            fontFamily: 'cairo',
                            fontSize: 16,
                            color: AppColors.textPrimaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: noteController,
                          maxLines: 4,
                          minLines: 3,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: 'أضف ملاحظتك هنا...',
                            hintStyle: TextStyle(
                              color: AppColors.darkGrey,
                              fontFamily: 'cairo',
                            ),
                            filled: true,
                            fillColor: AppColors.primaryLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                isSubmitting || selectedFile?.path == null
                                ? null
                                : () {
                                    context.read<UpgradeCubit>().submit(
                                      filePath: selectedFile!.path!,
                                      fileName: selectedFile!.name,
                                      notes: noteController.text,
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: isSubmitting
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'إرسال',
                                    style: TextStyle(
                                      fontFamily: 'cairo',
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

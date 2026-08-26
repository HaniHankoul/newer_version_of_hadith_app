import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';

class PictureBottomSheetBody extends StatelessWidget {
  const PictureBottomSheetBody({super.key, required this.onImageSelected});

  final ValueChanged<XFile> onImageSelected;

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (!context.mounted || image == null) return;
    Navigator.of(context).pop();
    onImageSelected(image);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(text: 'اختر مصدر الصورة', fontSize: 18),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('المعرض'),
              onTap: () => _pickImage(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('الكاميرا'),
              onTap: () => _pickImage(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }
}

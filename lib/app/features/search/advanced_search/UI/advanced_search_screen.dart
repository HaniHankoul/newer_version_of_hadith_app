import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_reactive_form.dart';

import '../../../../core/app_theme.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: customAppbar('البحث المتقدم'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GeneralSizes.medium,
          vertical: GeneralSizes.large,
        ),
        child: Column(
          children: [
            CustomReactiveForm(
              validators: [],
              formKey: 'search',
              hintText: 'ابحث عن حديث',
              icon: Icons.search,
              validationMessages: {},
            ),
          ],
        ),
      ),
    );
  }
}

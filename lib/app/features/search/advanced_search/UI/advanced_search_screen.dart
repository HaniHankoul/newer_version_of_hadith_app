import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/core/widgets/custom_appbar.dart';
import 'package:hadith_app/app/core/widgets/custom_reactive_form.dart';
import 'package:hadith_app/app/core/widgets/custom_text.dart';
import 'package:hadith_app/app/core/widgets/universal_button.dart';
import 'package:hadith_app/app/features/search/advanced_search/UI/widgets/filtering_section.dart';
import 'package:hadith_app/app/features/search/advanced_search/logic/advanced_search_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/helper/assets.dart';
import '../logic/advanced_search_states.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: customAppbar('البحث المتقدم'),
      body: SingleChildScrollView(
        child: Padding(
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
              verticalMediumSpacing(),
              FilteringSection(),
              verticalLargeSpacing(),
              BlocBuilder<AdvancedSearchCubit, AdvancedSearchStates>(
                builder: (context, state) {
                  if (state is AdvancedSearchLoading) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: LottieBuilder.asset(
                            Assets.assetsImagesLottiesLoadingCircle,
                          ),
                        ),
                        CustomText(
                          text: 'الرجاء الانتظار ...',
                          color: AppColors.primary,
                        ),
                      ],
                    );
                  } else if (state is AdvancedSearchSuccess) {
                    return Container(
                      child: Text('bloc body state ${state.toString()}'),
                    );
                  }
                  return Container(child: Text('Cubit ${state.toString()}'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

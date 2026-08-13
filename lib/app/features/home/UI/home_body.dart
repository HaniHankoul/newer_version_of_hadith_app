import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/widgets/custom_text_field.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../Logic/search_bloc/search_cubit.dart';
import '../Logic/search_bloc/search_cubit_state.dart';
import 'widgets/container_element.dart';
import 'widgets/todays_hadith_header.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: GeneralSizes.large,
                    vertical: GeneralSizes.medium,
                  ),
                  child: CustomTextField(
                    onFieldSubmitted: (value) {
                      context.read<SearchCubit>().search(value);
                    },
                    hintText: 'ابحث عن حديث ',
                    icon: Icons.search,
                  ),
                ),
                BlocBuilder<SearchCubit, SearchCubitState>(
                  builder: (context, state) {
                    return body(context, state);
                  },
                ),
              ]
              .animate(interval: 150.ms)
              .fade(duration: 250.ms)
              .slide(begin: Offset(0, 0.3), duration: 200.ms),
    );
  }
}

Widget body(BuildContext context, SearchCubitState state) {
  switch (state) {
    case SearchCubitInitial():
      return Column(
        children: [
          verticalMediumSpacing(),
          TodaysHadithHeader(),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: GeneralSizes.large,
            crossAxisSpacing: GeneralSizes.large,
            padding: EdgeInsets.symmetric(horizontal: GeneralSizes.large),
            children:
                [
                      ContainerElement(
                        onTap: () {},
                        icon: Icons.people,
                        title: "احاديث منتشرة لا تصح",
                      ),
                      ContainerElement(
                        onTap: () {},
                        icon: Icons.people,
                        title: "الكتب و المصادر",
                      ),
                      ContainerElement(
                        onTap: () {
                          context.push('/tellers');
                        },
                        icon: Icons.people,
                        title: "تراجم الرواة",
                      ),
                      ContainerElement(
                        onTap: () {
                          context.push('/speakers');
                        },
                        icon: Icons.person,
                        title: "تراجم المحدثين",
                      ),
                    ]
                    .animate(interval: 230.ms)
                    .fade(duration: 250.ms)
                    .slide(
                      begin: Offset(-0.5, 0),
                      end: Offset(0, 0),
                      duration: 200.ms,
                    ),
          ),
        ],
      );
    case SearchCubitLoading():
      return CircularProgressIndicator();
    case SearchCubitSuccess():
      return CustomText(text: 'sad');
    case SearchCubitError():
      return CustomText(text: state.errorMessage);
    default:
      return CustomText(text: 'sdkhfkshalkhf');
  }
}

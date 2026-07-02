import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/features/home/UI/widgets/container_element.dart';
import '../../../core/app_theme.dart';
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
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'ابحث عن حديث',
                        hintStyle: TextStyle(
                          color: AppColors.primary,
                          fontFamily: "cairo",
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.primary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
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
              ]
              .animate(interval: 150.ms)
              .fade(duration: 250.ms)
              .slide(begin: Offset(0, 0.3), duration: 200.ms),
    );
  }
}

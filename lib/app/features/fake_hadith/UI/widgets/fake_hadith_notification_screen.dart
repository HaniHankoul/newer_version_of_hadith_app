import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith_app/app/core/widgets/loading_card.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text.dart';
import 'fake_hadith_card.dart';
import '../../data/model/fake_hadith_response.dart';
import '../../data/repo/fake_hadith_repo.dart';

class FakeHadithNotificationScreen extends StatefulWidget {
  const FakeHadithNotificationScreen({super.key, required this.fakeHadithId});

  final String fakeHadithId;

  @override
  State<FakeHadithNotificationScreen> createState() =>
      _FakeHadithNotificationScreenState();
}

class _FakeHadithNotificationScreenState
    extends State<FakeHadithNotificationScreen> {
  late Future<FakeHadithResponse> _future;

  @override
  void initState() {
    super.initState();

    _future = FakeHadithRepo().getFakeHadithById(widget.fakeHadithId);
  }

  void _retry() {
    setState(() {
      _future = FakeHadithRepo().getFakeHadithById(widget.fakeHadithId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: customAppbar(' حديث منتشر لا يصح'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<FakeHadithResponse>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingCard();
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(text: 'تعذر تحميل الحديث', fontSize: 18),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _retry,
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final hadith = snapshot.data;

                  if (hadith == null) {
                    return Center(
                      child: CustomText(text: 'الحديث غير موجود', fontSize: 18),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: FakeHadithCard(item: hadith, showFullText: true),
                  );
                },
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            //   child: SizedBox(
            //     width: double.infinity,
            //     height: 52,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         context.go('/');
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.primary,
            //         foregroundColor: Colors.white,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //       ),
            //       child: const Text(
            //         'العودة إلى الصفحة الرئيسية',
            //         style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

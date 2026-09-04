import 'package:flutter/material.dart';
import 'package:hadith_app/app/core/helper/general_sizes.dart';
import 'package:hadith_app/app/features/home/data/models/search_model.dart';

import '../../../../core/widgets/hadith_card.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.res});
  final SearchResponseModel res;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: res.items?.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: GeneralSizes.medium),
        child: HadithCard(items: res.items![index]),
      ),
    );
  }
}

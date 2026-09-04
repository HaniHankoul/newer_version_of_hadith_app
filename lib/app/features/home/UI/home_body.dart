import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../core/app_theme.dart';
import '../../../core/helper/general_sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/loading_card.dart';
import '../Logic/search_bloc/search_cubit.dart';
import '../Logic/search_bloc/search_cubit_state.dart';
import '../data/models/search_query_model.dart';
import 'widgets/container_element.dart';
import 'widgets/search_results.dart';
import 'widgets/todays_hadith_header.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TextEditingController _searchController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechAvailable = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    final available = await _speechToText.initialize(
      onStatus: (status) {
        if (mounted) setState(() => _isListening = status == 'listening');
      },
      onError: (_) {
        if (mounted) setState(() => _isListening = false);
      },
    );
    if (mounted) setState(() => _speechAvailable = available);
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _resetSearch() {
    _speechToText.stop();
    _searchController.clear();
    context.read<SearchCubit>().reset();
    FocusScope.of(context).unfocus();
  }

  Future<void> _toggleVoiceInput() async {
    if (!_speechAvailable) {
      await _initializeSpeech();
      if (!_speechAvailable) return;
    }

    if (_isListening) {
      await _speechToText.stop();
      return;
    }

    await _speechToText.listen(
      onResult: (result) {
        _searchController.value = _searchController.value.copyWith(
          text: result.recognizedWords,
          selection: TextSelection.collapsed(
            offset: result.recognizedWords.length,
          ),
        );
      },
      listenOptions: SpeechListenOptions(localeId: 'ar_SA'),
    );
    if (mounted) setState(() => _isListening = true);
  }

  @override
  void dispose() {
    _speechToText.stop();
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

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
                    controller: _searchController,
                    onFieldSubmitted: (value) {
                      context.read<SearchCubit>().search(
                        SearchBodyModel(
                          query: value,
                          sort: 'RELEVANCE',
                          mode: 'EXACT',
                          page: 1,
                          size: 10,
                          includeExplanation: false,
                        ),
                      );
                    },
                    hintText: 'ابحث عن حديث ',
                    icon: HugeIcons.strokeRoundedSearch01,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'البحث الصوتي',
                          onPressed: _toggleVoiceInput,
                          icon: Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            color: AppColors.primary,
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          IconButton(
                            tooltip: 'إلغاء البحث',
                            onPressed: _resetSearch,
                            icon: Icon(Icons.close, color: AppColors.primary),
                          ),
                      ],
                    ),
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
          verticalSmallSpacing(),
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
                        onTap: () {
                          context.push('/fakeHadith');
                        },
                        icon: HugeIcons.strokeRoundedAlert01,
                        title: "احاديث منتشرة لا تصح",
                      ),
                      ContainerElement(
                        onTap: () {
                          context.push('/books');
                        },
                        icon: HugeIcons.strokeRoundedBook01,

                        title: "الكتب و المصادر",
                      ),
                      ContainerElement(
                        onTap: () {
                          context.push('/rawi');
                        },
                        icon: HugeIcons.strokeRoundedUser,
                        title: "تراجم الرواة",
                      ),
                      ContainerElement(
                        onTap: () {
                          context.push('/muhaddiths');
                        },
                        icon: HugeIcons.strokeRoundedBook04,
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
      return LoadingCard();
    case SearchCubitSuccess():
      return SearchResults(res: state.searchModel);
    case SearchCubitError():
      return CustomText(text: state.errorMessage);
    default:
      return CustomText(text: 'sdkhfkshalkhf');
  }
}

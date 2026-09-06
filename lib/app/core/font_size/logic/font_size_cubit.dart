import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/general_sizes.dart';
import '../../helper/shared/shared_init.dart';
import 'font_size_state.dart';

class FontSizeCubit extends Cubit<FontSizeState> {
  FontSizeCubit()
    : super(const FontSizeState(fontSize: GeneralSizes.hadithFontSize));

  static const double minimumFontSize = 12;
  static const double maximumFontSize = 28;

  Future<void> loadFontSize() async {
    final savedFontSize = await UserPreferences.getFontSize();
    if (isClosed || savedFontSize == null) return;

    emit(FontSizeState(fontSize: savedFontSize));
  }

  Future<void> selectFontSize(double fontSize) async {
    final selectedFontSize = fontSize.clamp(minimumFontSize, maximumFontSize);
    emit(FontSizeState(fontSize: selectedFontSize));
    await UserPreferences.saveFontSize(selectedFontSize);
  }
}

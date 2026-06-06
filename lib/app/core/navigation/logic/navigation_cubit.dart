import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationState { home, search, profile, settings, notification }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.home);
  void navigate(NavigationState state) {
    emit(state);
    print('navigating to $state');
  }
}

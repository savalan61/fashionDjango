import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomTabsNotifier extends StateNotifier<int> {
  BottomTabsNotifier() : super(0);

  void setTab(int i) => state = i;
}

final bottomTabNotifier = StateNotifierProvider<BottomTabsNotifier, int>((ref) => BottomTabsNotifier());

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnBoardNotifier extends StateNotifier<int> {
  AnBoardNotifier() : super(0);

  void setPage(int i) => state = i;
}

final onBoardNotifier = StateNotifierProvider<AnBoardNotifier, int>((ref) => AnBoardNotifier());

import 'package:fashion_django/src/home/models/home_tab_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/enums.dart';

class HomeTabNotifier2 extends StateNotifier<HomeTabModel> {
  HomeTabNotifier2() : super(HomeTabModel.empty());

  void setQueryType(QueryType q) {
    state = state.copyWith(queryType: q);
  }

  void setIndex(String newIndex) {
    if (state.index != newIndex) {
      state = state.copyWith(index: newIndex);

      switch (newIndex) {
        case "All":
          setQueryType(QueryType.all);
          break;
        case "Popular":
          setQueryType(QueryType.popular);
          break;
        case "Unisex":
          setQueryType(QueryType.unisex);
          break;
        case "Men":
          setQueryType(QueryType.men);
          break;
        case "Women":
          setQueryType(QueryType.women);
          break;
        case "Kids":
          setQueryType(QueryType.kids);
          break;
        default:
          setQueryType(QueryType.all);
          break;
      }
    }
  }
}

final homeTabNotifier = StateNotifierProvider<HomeTabNotifier2, HomeTabModel>((ref) => HomeTabNotifier2());

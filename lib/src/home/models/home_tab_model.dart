import 'package:fashion_django/common/utils/enums.dart';

class HomeTabModel {
  const HomeTabModel({
    required this.queryType,
    required this.index,
  });

  HomeTabModel.empty()
      : queryType = QueryType.all,
        index = "All";

  final QueryType queryType;
  final String index;

  HomeTabModel copyWith({QueryType? queryType, String? index}) =>
      HomeTabModel(queryType: queryType ?? this.queryType, index: index ?? this.index);
}

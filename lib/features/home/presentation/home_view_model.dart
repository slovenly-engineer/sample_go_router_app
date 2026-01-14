import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/router/app_navigator.dart';
import '../../../core/router/router.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  void build() {}

  void onItemSelected(String id) {
    ref.read(appNavigatorProvider).navigateTo(ItemDetailRoute(id: id));
  }
}

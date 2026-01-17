import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sample_go_router_app/core/router/app_navigator.dart';
import 'package:sample_go_router_app/core/router/router.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  void build() {}

  Future<void> onItemSelected(String id) {
    return ref.read(appNavigatorProvider).navigateTo(ItemDetailRoute(id: id));
  }
}

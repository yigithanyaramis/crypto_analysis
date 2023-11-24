import 'package:mobx/mobx.dart';

part 'main_view_model.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store {
  // State yönetimi için observable kullanarak bir currentIndex tanımlanmış.
  @observable
  int currentIndex = 0;

  // Index değişikliğini yönetmek için action tanımlanmış.
  @action
  void changePage(int index) {
    currentIndex = index;
  }
}

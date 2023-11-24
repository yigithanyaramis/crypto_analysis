import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/bottom_navigation/bottom_navigation_constants.dart';
import '../../core/constants/color/color_constants.dart';
import '../home/home_view.dart';
import '../news/news_view.dart';
import '../signals/signals_view.dart';
import '../vip/vip_view.dart';
import 'main_view_model.dart';

class MainView extends StatelessWidget {
  final MainViewModel _store = MainViewModel();

  MainView({super.key});

  final _controller = NotchBottomBarController(index: 0);
  final _colorConstants = ColorConstants.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Observer(
          builder: (_) {
            // _store.currentIndex'e göre doğru sayfayı göster
            switch (_store.currentIndex) {
              case BottomNavigationConstants.homeView:
                return const HomeView();
              case BottomNavigationConstants.newsView:
                return const NewsView();
              case BottomNavigationConstants.signalsView:
                return const SignalsView();
              case BottomNavigationConstants.vipView:
                return const VipView();
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: AnimatedNotchBottomBar(
          showShadow: false,
          showLabel: false,
          color: ColorConstants.instance.primaryColor,
          bottomBarItems: [
            _buildBottomBarItem(Icons.home),
            _buildBottomBarItem(Icons.newspaper),
            _buildBottomBarItem(Icons.electric_bolt_sharp),
            _buildBottomBarItem(FontAwesomeIcons.crown)
          ],
          notchBottomBarController: _controller,
          // Tıklama olayını dinle ve sayfayı değiştir
          onTap: _store.changePage,
        ),
      ),
    );
  }

  BottomBarItem _buildBottomBarItem(IconData icon) {
    return BottomBarItem(
      inActiveItem: Icon(
        icon,
        color: Colors.white,
      ),
      activeItem: Icon(
        icon,
        color: _colorConstants.primaryColor,
      ),
    );
  }
}

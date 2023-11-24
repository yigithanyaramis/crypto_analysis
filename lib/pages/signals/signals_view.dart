import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';
import '../../core/extension/string_extension.dart';
import '../../core/init/languages/locale_keys.g.dart';
import '../../product/model/signal_model.dart';
import 'signals_view_model.dart';

class SignalsView extends StatefulWidget {
  const SignalsView({super.key});

  @override
  State<SignalsView> createState() => _SignalsViewState();
}

// Sinyallerin görüntülendiği ekranın state sınıfı.
class _SignalsViewState extends BaseState<SignalsView> {
  // ViewModel ve PageController nesneleri tanımlanıyor.
  late final SignalsViewModel _viewModel;
  late final PageController _pageController;

  // State başlatılırken çalışan metod.
  @override
  void initState() {
    super.initState();
    // PageController nesnesi oluşturuluyor ve başlangıç sayfası belirleniyor.
    _pageController = PageController(initialPage: 0);
  }

  // Ekranın UI'sını oluşturan metod.
  @override
  Widget build(BuildContext context) {
    return BaseView<SignalsViewModel>(
      viewModel: SignalsViewModel(),
      onModelReady: (model) => _viewModel = model,
      onPageBuilder: (context, value) => buildBody(),
    );
  }

  // Ekranın ana gövdesini oluşturan metod.
  Widget buildBody() {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(LocaleKeys.signals_signals.translate)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWarning(), // Uyarı metni oluşturan metod.
            _buildMenu(), // Menüyü oluşturan metod.
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  buildObserver(
                      0), // Gözlemci ile sinyal listesini gösteren metod.
                  Observer(
                    builder: (context) => _viewModel.user != null
                        ? isVip(_viewModel.user!.premiumFinishDate)
                            ? buildObserver(
                                1) // VIP sinyallerini gösteren metod.
                            : Center(
                                child:
                                    Text(LocaleKeys.signals_no_vip.translate))
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // VIP durumunu kontrol eden metod.
  bool isVip(String? finishPremiumDate) {
    finishPremiumDate ??= '01.01.2023';
    DateTime finishDate = DateFormat('dd.MM.y').parse(finishPremiumDate);
    DateTime nowDate = DateTime.now();
    return !finishDate.isBefore(nowDate);
  }

  // Gözlemci widget'ını kullanarak listeyi gösteren metod.
  Widget buildObserver(int index) {
    return Observer(builder: (context) => _buildListView(index));
  }

  // Menüyü oluşturan metod.
  Widget _buildMenu() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: colorConstants.primaryColor,
        borderRadius: borderConstants.borderRadiusLowAll,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => _changePage(0),
                child: Text(
                  LocaleKeys.signals_free.translate.toUpperCase(),
                  style: TextStyle(color: colorConstants.secondaryColor),
                ),
              ),
            ),
            const VerticalDivider(color: Colors.grey),
            Expanded(
              child: TextButton(
                onPressed: () => _changePage(1),
                child: Text(
                  'VIP',
                  style: TextStyle(color: colorConstants.secondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sayfa değişikliğini yöneten metod.
  void _changePage(int pageIndex) {
    _pageController.animateToPage(pageIndex,
        curve: Curves.easeInOut, duration: durationConstants.highDuration);
  }

  // ListView içerisindeki elemanları gösteren metod.
  Widget _buildListView(int selectIndex) {
    List<SignalModel> signal =
        selectIndex == 0 ? _viewModel.signalList : _viewModel.signalVipList;

    return ListView.builder(
      itemCount: signal.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          decoration: BoxDecoration(
            color: colorConstants.primaryColor,
            borderRadius: borderConstants.borderRadiusMediumAll,
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(signal[index].imageUrl),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            signal[index].coin,
                            style: TextStyle(
                              color: colorConstants.secondaryColor,
                              fontSize: 17,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${LocaleKeys.home_date.translate}: ${signal[index].signalDate}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildText(LocaleKeys.signals_current_price.translate,
                        Colors.white, 17),
                    _buildText(signal[index].currentPrice, Colors.white, 17),
                    _buildText(
                      '%${(((double.parse(signal[index].currentPrice) - double.parse(signal[index].enter)) / double.parse(signal[index].enter)) * 100).toStringAsFixed(2)}',
                      double.parse(signal[index].currentPrice) >=
                              double.parse(signal[index].enter)
                          ? Colors.green
                          : Colors.red,
                      17,
                    ),
                  ],
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildContainer(
                          '${LocaleKeys.signals_buy.translate}: ${signal[index].enter}',
                          Colors.green,
                        ),
                        _buildContainer(
                          '${LocaleKeys.signals_capital.translate}: %${signal[index].capital}',
                          Colors.orange,
                        ),
                      ],
                    ),
                    for (int i = 1; i <= 4; i++)
                      _buildTargetContainer(
                        i,
                        signal[index].targetStatus,
                        i == 1
                            ? signal[index].targetOne
                            : i == 2
                                ? signal[index].targetTwo
                                : i == 3
                                    ? signal[index].targetThree
                                    : signal[index].targetFour,
                        signal[index].enter,
                      ),
                    const SizedBox(height: 10),
                    _buildContainer(
                      '${LocaleKeys.signals_stoploss.translate}: ${signal[index].stop}',
                      Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Uyarı kartını oluşturan metod.
  Widget _buildWarning() {
    return Card(
      color: colorConstants.primaryColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.red),
        borderRadius: borderConstants.borderRadiusMediumAll,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          LocaleKeys.signals_risk.translate,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Metin widget'ını oluşturan yardımcı metod.
  Widget _buildText(String text, Color color, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Roboto',
      ),
    );
  }

  // Renkli konteyner widget'ını oluşturan yardımcı metod.
  Widget _buildContainer(String text, Color color) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderConstants.borderRadiusLowAll,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Hedef konteyner widget'ını oluşturan yardımcı metod.
  Widget _buildTargetContainer(
      int targetNumber, int targetStatus, String target, String enter) {
    return Container(
      margin: paddingConstants.topMedPadding,
      decoration: BoxDecoration(
        color: targetStatus >= targetNumber
            ? Colors.blue.shade800
            : colorConstants.backgroundColor,
        borderRadius: borderConstants.borderRadiusLowAll,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildText('${LocaleKeys.signals_target.translate} $targetNumber:',
                Colors.white, 15),
            _buildText(target, Colors.white, 15),
            _buildText(
              '%${(((double.parse(target) - double.parse(enter)) / double.parse(enter)) * 100).toStringAsFixed(2)}',
              Colors.green,
              15,
            ),
          ],
        ),
      ),
    );
  }
}

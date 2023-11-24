import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';
import '../../core/constants/app/app_constants.dart';
import '../../core/constants/navigation/navigation_constants.dart';
import '../../core/extension/string_extension.dart';
import '../../core/init/languages/locale_keys.g.dart';
import '../../core/init/navigation/navigation_service.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

const double _lowHeightWidth = 5;
const double _mediumHeightWidth = 10;

// _HomeViewState sınıfı, HomeView'in durumunu yönetir ve arayüzünü oluşturur.
class _HomeViewState extends BaseState<HomeView> {
  // HomeViewModel tipinde bir değişken tanımlar.
  late final HomeViewModel _viewModel;

  // Ana arayüzü oluşturan metod.
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        viewModel: HomeViewModel(),
        onModelReady: (model) {
          _viewModel = model; // ViewModel'i başlatır.
        },
        onPageBuilder: (context, value) =>
            buildBody()); // Ana gövdeyi oluşturur.
  }

  // Scaffold içindeki ana gövdeyi oluşturan metod.
  Widget buildBody() {
    return Scaffold(
        appBar: AppBar(
          // Uygulamanın üst kısmındaki AppBar widget'ını oluşturur.
          title: const Center(child: Text(ApplicationConstants.appName)),
          leading: IconButton(
            icon: const Icon(Icons.person_pin),
            onPressed: () {
              // Profil görünümüne yönlendirir.
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.profileView);
            },
          ),
        ),
        body: Padding(
          // İçeriği belirli bir boşlukla çevreleyen Padding widget'ını oluşturur.
          padding: paddingConstants.basePadding,
          child: SingleChildScrollView(
            // Dikey kaydırma yapılabilen bir widget.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildJoinTelegram(), // Telegram'a katılma kartını oluşturur.
                const SizedBox(height: _mediumHeightWidth),
                _buildMarketCap(), // Piyasa değeri başlığını oluşturur.
                const SizedBox(height: _mediumHeightWidth),
                _buildMarketCapGrid(), // Piyasa değeri gridini oluşturur.
                const SizedBox(height: _mediumHeightWidth),
                _buildAlternative(), // Alternatifler kartını oluşturur.
                const SizedBox(height: _mediumHeightWidth),
                _buildLastSignalText(), // Son sinyal metnini oluşturur.
                const SizedBox(height: _mediumHeightWidth),
                _buildLastSignal(), // Son sinyali oluşturur.
                _buildLastSignalItem(), // Son sinyal öğesini oluşturur.
                _buildWarning(), // Uyarı kartını oluşturur.
              ],
            ),
          ),
        ));
  }

// Son sinyal öğesini oluşturan widget fonksiyonu.
  Widget _buildLastSignalItem() {
    return Observer(
        builder: (context) => _viewModel.signal != null
            ? Container(
                // Sinyal varsa görsel ve bilgileri içeren bir konteyner oluşturur.
                margin: const EdgeInsets.symmetric(
                    vertical: _lowHeightWidth, horizontal: 2),
                decoration: BoxDecoration(
                    color: colorConstants.primaryColor,
                    borderRadius: borderConstants.borderRadiusMediumAll),
                child: Padding(
                  padding: paddingConstants.allMedPadding,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              // Sinyalin görselini gösteren bölüm.
                              padding: paddingConstants.allLowPadding,
                              child: Image.network(_viewModel.signal!.imageUrl),
                            ),
                          ),
                          const SizedBox(
                            width: _mediumHeightWidth,
                          ),
                          Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Sinyalin adını ve tarihini gösteren bölüm.
                                  Text(
                                    _viewModel.signal!.coin,
                                    style: TextStyle(
                                        color: colorConstants.secondaryColor,
                                        fontSize: 17,
                                        fontFamily: 'Roboto'),
                                  ),
                                  const SizedBox(
                                    height: _lowHeightWidth,
                                  ),
                                  Text(
                                    '${LocaleKeys.home_date.translate}: ${_viewModel.signal!.signalDate}',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(height: _lowHeightWidth),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Mevcut fiyat ve yüzdelik değişimi gösteren bölüm.
                          Text(LocaleKeys.signals_current_price.translate,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Roboto')),
                          Text(_viewModel.signal!.currentPrice,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Roboto')),
                          Text(
                              '%${(((double.parse(_viewModel.signal!.currentPrice) - double.parse(_viewModel.signal!.enter)) / double.parse(_viewModel.signal!.enter)) * 100).toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: double.parse(
                                              _viewModel.signal!.currentPrice) >
                                          double.parse(_viewModel.signal!.enter)
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 17,
                                  fontFamily: 'Roboto')),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox
                .shrink()); // Eğer sinyal yoksa boş bir widget döndürür.
  }

  // Uyarı mesajını gösteren widget fonksiyonu.
  Widget _buildWarning() {
    return Card(
      // Risk uyarısını içeren bir kart widget'ı oluşturur.
      color: colorConstants.primaryColor,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.red),
          borderRadius: borderConstants.borderRadiusMediumAll),
      child: Padding(
        padding: paddingConstants.allMedPadding,
        child: Text(
          // Uyarı metnini içerir.
          LocaleKeys.home_risk.translate,
          style: const TextStyle(
              fontFamily: 'Roboto', fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

// Son sinyali gösteren widget fonksiyonu.
  Widget _buildLastSignal() {
    return const SizedBox
        .shrink(); // Şu an için bu widget boş bir görünüm döndürüyor.
  }

// Son sinyalin metnini gösteren widget fonksiyonu.
  Widget _buildLastSignalText() {
    return Row(
      children: [
        Icon(
          Icons.alarm,
          color: colorConstants.secondaryColor,
        ),
        const SizedBox(width: _mediumHeightWidth),
        Text(
          LocaleKeys.home_last_signal.translate,
          style: const TextStyle(
              color: Colors.white, fontSize: 19, fontFamily: 'Roboto'),
        ),
      ],
    );
  }

  // Alternatif bilgileri gösteren widget fonksiyonu.
  Widget _buildAlternative() {
    return Card(
      color: colorConstants.primaryColor,
      child: ListTile(
        title: Text(
          LocaleKeys.home_alternative.translate,
          style: TextStyle(
              color: colorConstants.secondaryColor,
              fontSize: 20,
              fontFamily: 'Roboto'),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.home_fear_greed_index.translate,
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Roboto'),
            ),
            Observer(
                builder: (context) => _viewModel.marketCap != null
                    ? Text(
                        _viewModel.marketCap!.fearGreed.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto'),
                      )
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  // Piyasa değerini gösteren grid'i oluşturan widget fonksiyonu.
  Widget _buildMarketCapGrid() {
    return SizedBox(
      height: 158,
      child: Observer(
          builder: (context) => _viewModel.marketCap != null
              ? GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.3,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: [
                    Card(
                      color: colorConstants.primaryColor,
                      child: ListTile(
                        title: Text(
                          LocaleKeys.home_btc_price.translate,
                          style: TextStyle(
                              color: colorConstants.secondaryColor,
                              fontSize: 14,
                              fontFamily: 'Roboto'),
                        ),
                        subtitle: Text(
                          '\$${_viewModel.marketCap!.price}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    Card(
                      color: colorConstants.primaryColor,
                      child: ListTile(
                        title: Text(
                          LocaleKeys.home_btc_change_24h.translate,
                          style: TextStyle(
                              color: colorConstants.secondaryColor,
                              fontSize: 14,
                              fontFamily: 'Roboto'),
                        ),
                        subtitle: Text(
                          '${_viewModel.marketCap!.change24H}%',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    Card(
                      color: colorConstants.primaryColor,
                      child: ListTile(
                        title: Text(
                          LocaleKeys.home_btc_market_cap.translate,
                          style: TextStyle(
                              color: colorConstants.secondaryColor,
                              fontSize: 14,
                              fontFamily: 'Roboto'),
                        ),
                        subtitle: Text(
                          '\$${_viewModel.marketCap!.marketCap}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    Card(
                      color: colorConstants.primaryColor,
                      child: ListTile(
                        title: Text(
                          LocaleKeys.home_btc_total_volume.translate,
                          style: TextStyle(
                              color: colorConstants.secondaryColor,
                              fontSize: 14,
                              fontFamily: 'Roboto'),
                        ),
                        subtitle: Text(
                          '\$${_viewModel.marketCap!.totalVolume}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    )
                  ],
                )
              : const SizedBox.shrink()),
    );
  }

  // Piyasa değerini gösteren widget fonksiyonu.
  Widget _buildMarketCap() {
    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.bitcoinSign,
          color: Colors.orange,
        ),
        const SizedBox(width: _mediumHeightWidth),
        Text(
          LocaleKeys.home_btc_market_cap.translate,
          style: const TextStyle(
              color: Colors.white, fontSize: 19, fontFamily: 'Roboto'),
        ),
      ],
    );
  }

  // Telegram'a katılma kartını oluşturan widget fonksiyonu.
  Widget _buildJoinTelegram() {
    return Card(
      color: colorConstants.primaryColor,
      child: InkWell(
        onTap: () {
          launchURL(
              _viewModel.contact?.telegram ?? 'https://t.me/',
              mode: LaunchMode.externalApplication);
        },
        child: ListTile(
          title: Text(
            LocaleKeys.home_join_out_telegram_channel.translate,
            style: const TextStyle(
                color: Colors.blue, fontSize: 18, fontFamily: 'Roboto'),
          ),
          leading: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: borderConstants.borderRadiusLowAll),
            child: const Center(
                child: Icon(
              FontAwesomeIcons.telegram,
              color: Colors.white,
              size: 32,
            )),
          ),
          subtitle: Text(
            '${LocaleKeys.home_join_now.translate} >',
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontFamily: 'Roboto'),
          ),
        ),
      ),
    );
  }

  // URL'yi açan metod.
  Future<void> launchURL(String url, {LaunchMode? mode}) async {
    mode ??= LaunchMode.platformDefault;

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: mode);
      } else {
        throw Exception('Cannot launch URL');
      }
    } catch (e) {
      // Hata durumunda SnackBar göster
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error URL : $url'),
          ),
        );
      });
    }
  }
}

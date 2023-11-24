import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';
import '../../core/constants/navigation/navigation_constants.dart';
import '../../core/extension/string_extension.dart';
import '../../core/init/languages/locale_keys.g.dart';
import '../../core/init/navigation/navigation_service.dart';
import 'profile_view_model.dart';

const double _mediumHeight = 10;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends BaseState<ProfileView> {
  late final ProfileViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        viewModel: ProfileViewModel(),
        onModelReady: (model) {
          _viewModel = model;
        },
        onPageBuilder: (context, value) => buildBody());
  }

  Widget buildBody() {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text(LocaleKeys.profile_profile.translate)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              NavigationService.instance.navigateToPop();
            },
          ),
        ),
        body: Padding(
          padding: paddingConstants.basePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kullanıcının fotoğrafı varsa göster
              if (FirebaseAuth.instance.currentUser?.photoURL != null)
                Center(
                  child: ClipOval(
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        FirebaseAuth.instance.currentUser?.photoURL ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
              const SizedBox(height: _mediumHeight),
              // Kartları oluşturan metodu çağır
              _buildCard(
                icon: Icons.person,
                title: LocaleKeys.profile_full_name.translate,
                text: FirebaseAuth.instance.currentUser?.displayName ?? '',
              ),
              const SizedBox(height: _mediumHeight),
              _buildCard(
                icon: Icons.email,
                title: LocaleKeys.profile_email.translate,
                text: FirebaseAuth.instance.currentUser?.email ?? '',
              ),
              const SizedBox(height: _mediumHeight),
              // VIP kartını oluşturan Observer
              Observer(
                builder: (context) => _buildCard(
                  icon: FontAwesomeIcons.crown,
                  title: 'VIP',
                  text: _viewModel.user != null
                      ? isVip(_viewModel.user!.premiumFinishDate)
                          ? '${remainingDays(_viewModel.user!.premiumFinishDate)} ${LocaleKeys.profile_days_left.translate}'
                          : LocaleKeys.profile_no_vip.translate
                      : LocaleKeys.profile_no_vip.translate,
                ),
              ),
              const Spacer(),
              _buildSignOutAccount(),
              _buildDeleteAccount(),
            ],
          ),
        ));
  }

  // Hesaptan çıkış kartı
  Widget _buildSignOutAccount() {
    return InkWell(
      onTap: () async {
        try {
          User? currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            await FirebaseAuth.instance.signOut();
          } else {
            debugPrint(
                "Kullanıcı zaten oturum açmamış veya bilinmeyen bir durum var.");
          }
          NavigationService.instance
              .navigateToPage(path: NavigationConstants.loginView);
        } catch (e) {
          if (kDebugMode) {
            debugPrint(e.toString());
          }
        }
      },
      child: Card(
        color: colorConstants.primaryColor,
        child: Padding(
          padding: paddingConstants.allLowPadding,
          child: ListTile(
            title: Text(
              LocaleKeys.profile_exit.translate,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Roboto'),
            ),
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: borderConstants.borderRadiusLowAll),
              child: const Center(
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Hesabı sil kartı
  Widget _buildDeleteAccount() {
    return InkWell(
      onTap: () async {
        _showDeleteConfirmationDialog();
      },
      child: Card(
        color: colorConstants.primaryColor,
        child: Padding(
          padding: paddingConstants.allLowPadding,
          child: ListTile(
            title: Text(
              LocaleKeys.profile_delete_account.translate,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Roboto'),
            ),
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: borderConstants.borderRadiusLowAll),
              child: const Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Hesap silme onayı için bir dialog göster
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.profile_delete_account.translate),
          content: Text(LocaleKeys.profile_are_you_sure.translate),
          actions: [
            TextButton(
              child: Text(LocaleKeys.profile_close.translate),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(LocaleKeys.profile_yes.translate),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  User? currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    await currentUser.delete();
                    await FirebaseAuth.instance.signOut();
                    await _viewModel.deleteUser(currentUser.uid);
                    NavigationService.instance
                        .navigateToPage(path: NavigationConstants.loginView);
                  } else {
                    if (kDebugMode) {
                      debugPrint(
                          "Kullanıcı zaten oturum açmamış veya bilinmeyen bir durum var.");
                    }
                  }
                } catch (e) {
                  if (kDebugMode) {
                    debugPrint(e.toString());
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Bilgi kartları
  Widget _buildCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Card(
      color: colorConstants.primaryColor,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.blue, fontSize: 18, fontFamily: 'Roboto'),
        ),
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: borderConstants.borderRadiusLowAll),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        subtitle: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontFamily: 'Roboto'),
        ),
      ),
    );
  }

  // VIP bitiş tarihinden kalan gün sayısını hesapla
  int remainingDays(String? finishPremiumDate) {
    finishPremiumDate ??= '01.01.2023';
    DateTime finishDate = DateFormat('dd.MM.y').parse(finishPremiumDate);
    DateTime nowDate = DateTime.now();

    return finishDate.difference(nowDate).inDays;
  }

  // VIP'in bitip bitmediğini kontrol et
  bool isVip(String? finishPremiumDate) {
    finishPremiumDate ??= '01.01.2023';
    DateTime finishDate = DateFormat('dd.MM.y').parse(finishPremiumDate);
    DateTime nowDate = DateTime.now();
    bool finish = finishDate.isBefore(nowDate);

    return !finish;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/languages/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../core/extension/string_extension.dart';
import '../../core/init/network/services/firebase_service.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

const double _zero = 0;
const double _dHeight = .65;
const double _dHeightGoogleSignInButton = .85;
const double _dWidthGoogleSignInButtonLogo = .1;

class _LoginViewState extends BaseState<LoginView> {
  late final LoginViewModel _viewModel;
  User? currentUser;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        viewModel: LoginViewModel(),
        onModelReady: (model) {
          _viewModel = model;
        },
        onPageBuilder: (context, value) => buildBody());
  }

  @override
  void initState() {
    super.initState();
    currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Kullanıcı banlı mı kontrol et
        bool banCheck = await _viewModel.banCheck();
        if (banCheck) {
          // Banlı ise ilgili sayfaya yönlendir
          NavigationService.instance
              .navigateToPageClear(path: NavigationConstants.banView);
        } else {
          // Banlı değilse ana sayfaya yönlendir
          NavigationService.instance
              .navigateToPageClear(path: NavigationConstants.mainView);
        }
      });
    }
  }

  Widget buildBody() {
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Positioned(
          top: _zero,
          left: _zero,
          right: _zero,
          child: Container(
            color: Colors.white,
            child: Image.asset(
              imageConstants.logo,
            ),
          ),
        ),
        Positioned(
          bottom: _zero,
          left: _zero,
          right: _zero,
          child: Container(
            height: dynamicHeight(_dHeight),
            decoration: BoxDecoration(
                color: colorConstants.backgroundColor,
                borderRadius: borderConstants.borderRadiusHighAll),
            child: Padding(
              padding: paddingConstants.topMedPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(LocaleKeys.login_welcome.translate,
                      style: textTheme.headlineSmall),
                  SizedBox(
                    width: dynamicWidth(_dHeightGoogleSignInButton),
                    child: buildGoogleSignInButton(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Observer(
                        builder: (context) => Checkbox(
                            activeColor: colorConstants.primaryColor,
                            value: _viewModel.checkTermOfUse,
                            onChanged: (value) {
                              // Kullanıcının Gizlilik Politikası kabulünü güncelle
                              _viewModel.changeCheckTermOfUse(value ?? false);
                            }),
                      ),
                      Observer(
                        builder: (context) => InkWell(
                          onTap: _viewModel.contact != null
                              ? () {
                                  // Gizlilik Politikası bağlantısını aç
                                  launchURL(_viewModel.contact!.privacyPolicy,
                                      mode: LaunchMode.externalApplication);
                                }
                              : null,
                          child: Text(
                            LocaleKeys.login_privacy_policy_text.translate,
                            style: textTheme.bodyLarge,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget buildGoogleSignInButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: colorConstants.primaryColor),
      onPressed: handleGoogleSignIn,
      child: Padding(
        padding:
            paddingConstants.topMedPadding + paddingConstants.bottomMedPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imageConstants.google,
              width: dynamicWidth(_dWidthGoogleSignInButtonLogo),
            ),
            Text(
              LocaleKeys.login_google_sign_in.translate,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  void handleGoogleSignIn() async {
    if (_viewModel.checkTermOfUse) {
      await signInWithGoogle();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: durationConstants.mediumDuration,
          content: Text(LocaleKeys.login_please_check_box_term.translate),
        ),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await firebaseService.signInwithGoogle();
      await _viewModel.signIn();
      bool banCheck = await _viewModel.banCheck();
      if (banCheck) {
        // Banlı ise ilgili sayfaya yönlendir
        NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.banView);
      } else {
        // Banlı değilse ana sayfaya yönlendir
        NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.mainView);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error: $e');
      } // Hatanın detayını görmek için bu satırı ekleyin
      if (e is FirebaseAuthException) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: durationConstants.highDuration,
              content: Text(e.message ?? LocaleKeys.base_error.translate),
            ),
          );
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: durationConstants.highDuration,
              content: Text(LocaleKeys.base_error.translate),
            ),
          );
        });
      }
    }
  }

  Future<void> launchURL(String url, {LaunchMode? mode}) async {
    mode ??= LaunchMode.platformDefault;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: mode);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $url'),
          ),
        );
      });
    }
  }
}

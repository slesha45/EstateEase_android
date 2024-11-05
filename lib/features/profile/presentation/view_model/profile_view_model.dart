import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/profile/presentation/state/profile_state.dart';
// import 'package:final_assignment/features/profile/presentation/navigator/profile_navigator.dart';
// import 'package:final_assignment/features/profile/presentation/state/current_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final profileViewmodelProvider =
    StateNotifierProvider<ProfileViewmodel, CurrentProfileState>(
        (ref) => ProfileViewmodel(
              authUseCase: ref.watch(authUseCaseProvider),
              //navigator: ref.watch(profileNavigatorProvider),
              userSharedPrefs: ref.watch(userSharedPrefsProvider),
            ));

class ProfileViewmodel extends StateNotifier<CurrentProfileState> {
  final AuthUseCase authUseCase;
  //final ProfileNavigator navigator;
  final UserSharedPrefs userSharedPrefs;
  late LocalAuthentication _localAuth;

  ProfileViewmodel({
    //required this.navigator,
    required this.userSharedPrefs,
    required this.authUseCase,
  }) : super(CurrentProfileState.initial()) {
    initialize();
  }

  get context => null;
  Future<void> initialize() async {
    _localAuth = LocalAuthentication();
    await getCurrentUser();
    await checkFingerprint();
  }

  Future<void> getCurrentUser() async {
    try {
      state = state.copyWith(isLoading: true);
      final data = await authUseCase.getCurrentUser();
      data.fold(
        (l) {
          state = state.copyWith(isLoading: false, error: l.error);
          print('Error fetching current user: ${l.error}');
        },
        (r) {
          print('Current user: $r');
          state = state.copyWith(isLoading: false, authEntity: r);
        },
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Failed to fetch current user.');
      print('Error fetching current user: $e');
    }
  }

  Future<void> enableFingerprint() async {
    if (state.isFingerprintEnabled) {
      AwesomeDialog(
        context: AppNavigator.navigatorKey.currentContext!,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: 'Disable Fingerprint',
        desc: 'Are you sure you want to disable fingerprint?',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          state = state.copyWith(isFingerprintEnabled: false);
          userSharedPrefs.saveFingerPrintId('');
          showMySnackBar(message: 'Fingerprint disabled', color: Colors.red);
        },
      ).show();
    } else {
      bool authenticated = false;
      try {
        authenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate to enable fingerprint',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
            useErrorDialogs: true,
          ),
        );
      } catch (e) {
        showMySnackBar(
            message: 'Fingerprint authentication failed', color: Colors.red);
      }

      if (authenticated) {
        state = state.copyWith(isFingerprintEnabled: true);
        userSharedPrefs.saveFingerPrintId(state.authEntity!.userId ?? "");
        showMySnackBar(message: 'Fingerprint enabled', color: Colors.green);
      }
    }
  }

  Future<void> checkFingerprint() async {
    final currentUserId = state.authEntity!.userId;
    final result = await userSharedPrefs.checkId();
    result.fold(
      (l) {
        state = state.copyWith(isFingerprintEnabled: false);
      },
      (r) {
        if (r == currentUserId) {
          state = state.copyWith(isFingerprintEnabled: true);
        } else {
          state = state.copyWith(isFingerprintEnabled: false);
        }
      },
    );
  }

  void openEditProfileView() {
    // navigator.openEditProfileView();
  }

  void logout() {
    userSharedPrefs.removeUserToken();
    // navigator.openLoginView();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginView(),
    ));
  }
}

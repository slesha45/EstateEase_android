import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_assignment/core/common/provider/theme_view_model_provider.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:final_assignment/features/profile/presentation/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  bool showYesNoDialog = true;
  bool isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewmodelProvider);

    if (profileState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Information
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "${profileState.authEntity?.fName} ${profileState.authEntity?.lName}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${profileState.authEntity?.email}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Profile Menus
            ProfileMenu(
              text: "Enable Finger Print",
              icon: Icons.fingerprint_outlined,
              press: () {
                if (mounted) {
                  ref
                      .read(profileViewmodelProvider.notifier)
                      .enableFingerprint();
                }
              },
            ),
            const SizedBox(height: 15),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout_outlined,
              press: () {
                if (mounted) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    title: 'Logout',
                    desc: 'Are You Sure You Want To Logout?',
                    btnOkOnPress: () {
                      if (mounted) {
                        ref.read(authViewModelProvider.notifier).logout();
                      }
                    },
                    btnCancelOnPress: () {},
                  ).show();
                }
              },
            ),
            const SizedBox(height: 15),
            // Dark/Light Mode Toggle
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.brown.withOpacity(0.1),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dark Mode/Light Mode",
                        style: TextStyle(fontSize: 16, color: Colors.brown),
                      ),
                      Switch(
                        value: ref.watch(themeViewModelProvider),
                        onChanged: (value) {
                          ref
                              .read(themeViewModelProvider.notifier)
                              .changeTheme();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

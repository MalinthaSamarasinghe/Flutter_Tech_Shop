import 'components/profile_pic.dart';
import 'components/profile_menu.dart';
import '../../components/log_out.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/alert_widgets.dart';
import '../../components/theme_notifier.dart';

class ProfileScreen extends StatelessWidget {
  final String? userImage;
  final String? userUid;
  static String routeName = "/profile";

  const ProfileScreen({super.key, this.userImage, this.userUid});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false); // Access the ThemeNotifier
    bool value = themeNotifier.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(userImage: userImage, userUid: userUid ?? ''),
            const SizedBox(height: 20),
            /// My Account
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            /// Notifications
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            /// Settings
            ProfileMenu(
              text: "Dark Mode",
              icon: "assets/icons/Settings.svg",
              press: () {
                themeNotifier.setTheme(!value); // Change theme when toggled
              },
            ),
            /// Help Center
            ProfileMenu(
              text: "Get Help",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            /// Log Out
            ProfileMenu(
              text: "Exit",
              icon: "assets/icons/Log out.svg",
              press: () {
                Alerts.getInstance().twoButtonAlert(
                  context,
                  // Translate the message
                  title: "Log out",
                  msg: "Are you sure you want to log out of your account?",
                  btnNoText: "Cancel",
                  btnYesText: "Confirm",
                  functionNo:() {
                    Navigator.of(context).pop();
                  },
                  functionYes:() async {
                    await Logout().logout(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

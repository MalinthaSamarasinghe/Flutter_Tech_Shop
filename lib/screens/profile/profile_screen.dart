import 'components/profile_pic.dart';
import 'components/profile_menu.dart';
import '../../components/log_out.dart';
import 'package:flutter/material.dart';
import '../../components/alert_widgets.dart';

class ProfileScreen extends StatelessWidget {
  final String? userImage;
  static String routeName = "/profile";

  const ProfileScreen({super.key, this.userImage});

  @override
  Widget build(BuildContext context) {
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
            ProfilePic(userImage: userImage),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Options",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Get Help",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
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

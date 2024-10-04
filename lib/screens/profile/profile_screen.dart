import 'components/profile_pic.dart';
import 'components/profile_menu.dart';
import '../../components/log_out.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Log out'),
                    content: const Text("Are you sure you want to log out of your account?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Logout().logout(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          child: const Text("Confirm", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

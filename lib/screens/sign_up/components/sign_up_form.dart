import '../../../constants.dart';
import 'package:flutter/material.dart';
import '../../../helper/keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../components/custom_snack_bar.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../login_success/login_success_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conformPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// Email
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (newValue) => email = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                return kInvalidEmailError;
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          /// Password
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (newValue) => password = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                return kPassNullError;
              } else if (value.length < 6) {
                return kShortPassError;
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          /// Confirm Password
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => conformPassword = newValue,
            onChanged: (newValue) => conformPassword = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                return kPassNullError;
              } else if ((password != value)) {
                return kMatchPassError;
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Confirm Password",
              hintText: "Re-enter your password",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          /// Continue Button
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                if(await InternetConnectionChecker().hasConnection){
                  EasyLoading.show(status: "Please Wait", dismissOnTap: false);
                  userRegisterWithEmailAndPassword(context);
                } else {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    CustomSnackBar().showSnackBar(
                      context,
                      msg: 'No internet connection!',
                      snackBarTypes: SnackBarTypes.error,
                    );
                  });
                }
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  Future<void> userRegisterWithEmailAndPassword(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginSuccessScreen(successMessage: "Account created successfully!")), (route) => route.isFirst,
      );
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'email-already-in-use') {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomSnackBar().showSnackBar(
            context,
            msg: 'The account already exists for that email!',
            snackBarTypes: SnackBarTypes.error,
          );
        });
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomSnackBar().showSnackBar(
            context,
            msg: e.code,
            snackBarTypes: SnackBarTypes.error,
          );
        });
      }
    }
  }
}

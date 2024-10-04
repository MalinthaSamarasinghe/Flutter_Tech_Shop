import '../../../constants.dart';
import 'package:flutter/material.dart';
import '../../../helper/keyboard.dart';
import '../../sign_in/sign_in_screen.dart';
import '../../../components/no_account_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../components/custom_snack_bar.dart';
import '../../../components/custom_surfix_icon.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                KeyboardUtil.hideKeyboard(context);
                if(await InternetConnectionChecker().hasConnection){
                  resetPassword(context);
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
          const SizedBox(height: 16),
          const NoAccountText(),
        ],
      ),
    );
  }

  Future<void> resetPassword(context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email ?? '',
      );
      Future.delayed(const Duration(milliseconds: 100), () {
        CustomSnackBar().showSnackBar(
          context,
          msg: 'Password reset link sent to $email',
          snackBarTypes: SnackBarTypes.success,
        );
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()), (route) => route.isFirst,
      );
    } on FirebaseAuthException catch (e) {
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

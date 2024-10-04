import '../../../constants.dart';
import 'package:flutter/material.dart';
import '../../../helper/keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../components/custom_snack_bar.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../login_success/login_success_screen.dart';
import '../../forgot_password/forgot_password_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;

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
          /// Remember me and Forgot password
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                },
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          /// Continue Button
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                if(await InternetConnectionChecker().hasConnection){
                  userLoginWithEmailAndPassword(context);
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

  Future<void> userLoginWithEmailAndPassword(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginSuccessScreen(successMessage: "Login Success!")), (route) => route.isFirst,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomSnackBar().showSnackBar(
            context,
            msg: 'Email or Password is incorrect!',
            snackBarTypes: SnackBarTypes.error,
          );
        });
      } else if (e.code == 'too-many-requests') {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomSnackBar().showSnackBar(
            context,
            msg: 'This account has been temporarily disabled!',
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

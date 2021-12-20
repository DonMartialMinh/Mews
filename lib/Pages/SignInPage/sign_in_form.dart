import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mews/Authentication/authentication.dart';
import 'package:mews/Values/colors.dart';
import 'package:mews/Values/dimens.dart';
import 'package:mews/Values/font_sizes.dart';
import 'package:mews/Widgets/custom_text.dart';
import 'package:mews/Widgets/dock_button.dart';
import 'package:mews/Widgets/form_error.dart';
import 'package:mews/constants.dart';
import 'package:mews/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _passwordVisible = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizonPadding = AppDimen.spacing_3;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: buildEmailFormField()),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: buildPasswordFormField()),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: FormError(errors: errors)),
          const SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimen.horizontalSpacing,
            ),
            child: DockButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() && errors.isEmpty) {
                  _formKey.currentState!.save();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', 'useremail@gmail.com');
                  AuthenticationHelper()
                      .signIn(email.text, password.text)
                      .then((result) {
                    if (result == null) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(milliseconds: 800),
                        content: CustomText(
                          'Login success',
                          fontSize: FontSize.MEDIUM,
                          color: Colors.white,
                        ),
                      ));
                      Future.delayed(const Duration(milliseconds: 1100), () {
                        Navigator.pushNamed(context, RoutePaths.HOME);
                      });
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(milliseconds: 2000),
                        content: CustomText(
                          result,
                          fontSize: FontSize.MEDIUM,
                          color: Colors.white,
                        ),
                      ));
                    }
                  });
                }
              },
              name: "SIGN IN",
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                const TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                      fontSize: FontSize.SMALL, color: AppColor.colorTextLight),
                ),
                TextSpan(
                  text: "SIGN UP",
                  style: const TextStyle(
                      fontSize: FontSize.SMALL, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => {Navigator.pushNamed(context, RoutePaths.SIGNUP)},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: password,
      obscureText: !_passwordVisible,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: AppConstants.kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPassNullError);
        } else if (value.length < 8) {
          addError(error: AppConstants.kShortPassError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          child: const Icon(
            Icons.remove_red_eye_outlined,
          ),
          onTap: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kEmailNullError);
        }
        if (AppConstants.emailValidatorRegExp.hasMatch(value)) {
          removeError(error: AppConstants.kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kEmailNullError);
        } else if (!AppConstants.emailValidatorRegExp.hasMatch(value)) {
          addError(error: AppConstants.kInvalidEmailError);
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

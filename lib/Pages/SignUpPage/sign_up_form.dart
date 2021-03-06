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

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final conformPassword = TextEditingController();
  bool _passwordVisible = false;
  bool _conformPasswordVisible = false;
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
              child: buildNameFormField()),
          const SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: buildEmailFormField()),
          const SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: buildPhoneNumberFormField()),
          const SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: buildPasswordFormField()),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizonPadding),
            child: buildConformPassFormField(),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizonPadding),
              child: FormError(errors: errors)),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 32.0,
            child: DockButton(
              name: 'SIGN UP',
              onPressed: () {
                if (_formKey.currentState!.validate() && errors.isEmpty) {
                  _formKey.currentState!.save();
                  AuthenticationHelper()
                      .signUp(email.text, password.text)
                      .then((result) {
                    if (result == null) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(milliseconds: 800),
                        content: CustomText(
                          'User created',
                          fontSize: FontSize.MEDIUM,
                          color: Colors.white,
                        ),
                      ));
                      Future.delayed(const Duration(milliseconds: 1100), () {
                        Navigator.pop(context);
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
                  text: "Already have an account? ",
                  style: TextStyle(
                      fontSize: FontSize.SMALL, color: AppColor.colorTextLight),
                ),
                TextSpan(
                  text: "SIGN IN",
                  style: const TextStyle(
                      fontSize: FontSize.SMALL, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => {Navigator.pop(context)},
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      controller: conformPassword,
      obscureText: !_conformPasswordVisible,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPassNullError);
        }
        if (value.isNotEmpty && password.text == value) {
          removeError(error: AppConstants.kMatchPassError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPassNullError);
        } else if ((value != conformPassword.text)) {
          addError(error: AppConstants.kMatchPassError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        //hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          child: const Icon(
            Icons.remove_red_eye_outlined,
          ),
          onTap: () {
            setState(() {
              _conformPasswordVisible = !_conformPasswordVisible;
            });
          },
        ),
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

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.name,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kNamelNullError);
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneNumber,
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstants.kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstants.kPhoneNumberNullError);
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

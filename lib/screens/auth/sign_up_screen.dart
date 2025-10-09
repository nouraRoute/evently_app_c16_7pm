import 'package:evently_app/common/network/auth_service.dart';
import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/common/widgets/custom_main_button.dart';
import 'package:evently_app/common/widgets/custom_text_field.dart';
import 'package:evently_app/common/widgets/snackbar_helper.dart';
import 'package:evently_app/gen/assets.gen.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signupScreen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPAsswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')), //TODO:localization
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.appIcon.image(height: 140, width: 140),
                Text(
                  'Evently', //TODO:localization
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                  ),
                ),
                SizedBox(height: 24),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Name', //TODO:localization
                  prefixIcon: Assets.icons.personIcon.svg(
                    color: Theme.of(context).hoverColor,
                  ),
                  validator: (valu) {
                    if (valu == null || valu.isEmpty) {
                      return 'the name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                CustomTextField(
                  controller: emailController,
                  hintText: 'Email', //TODO:localization
                  prefixIcon: Assets.icons.emailIconSvg.svg(
                    color: Theme.of(context).hoverColor,
                  ),
                  validator: (valu) {
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(valu ?? '');
                    if (emailValid == false) {
                      return 'email not valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextField(
                  isPAssword: true,
                  controller: passwordController,
                  hintText: 'PAssword', //TODO:localization
                  prefixIcon: Assets.icons.passwordIcon.svg(
                    color: Theme.of(context).hoverColor,
                  ),
                  validator: (valu) {
                    if (valu == null || valu.isEmpty) {
                      return 'the password is required';
                    }
                    if (valu.length < 7) {
                      return 'the password must be mre than 8 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                CustomTextField(
                  isPAssword: true,

                  controller: confirmPAsswordController,
                  hintText: 'confirm PAssword', //TODO:localization
                  prefixIcon: Assets.icons.passwordIcon.svg(
                    color: Theme.of(context).hoverColor,
                  ),
                  validator: (valu) {
                    if (valu != passwordController.text) {
                      return 'password doesn\'t match';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  CustomMainButton(
                    text: 'Sign up', //TODO:localization
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ///
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await AuthService.registerNewUser(
                            UserModel(
                              email: emailController.text,
                              name: nameController.text,
                            ),
                            passwordController.text,
                          );

                          Navigator.of(context).pop();
                          SnackbarHelper.showSuccessSnackBar(
                            context,
                            'Signed up ',
                          );
                        } catch (e) {
                          SnackbarHelper.showErrorSnackBar(
                            context,
                            e.toString(),
                          );
                        }
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
                SizedBox(height: 24),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already Have Account ? ',
                      ), //TODO:localization
                      TextSpan(
                        text: 'Login', //TODO:localization
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.mainColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          },
                      ),
                    ],
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 24),
                Switch(
                  value: false,
                  onChanged: (value) {},
                  activeThumbImage: AssetImage(Assets.icons.enIcon.path),
                  inactiveThumbImage: AssetImage(Assets.icons.arIcon.path),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

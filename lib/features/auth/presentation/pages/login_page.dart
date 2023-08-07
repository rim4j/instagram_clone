import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/icons.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/common/constants/strings.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/common/widgets/input_text.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObsecured = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    AppFontSize appFontSize = AppFontSize(size: size);
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //title
              SizedBox(height: size.height * 0.1),
              Text(
                Strings.login,
                style: robotoBold.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                Strings.instagram,
                style: robotoBold.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: Dimens.medium),

              Text(
                Strings.enterDetails,
                style: robotoBold.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9797BD),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.medium),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //label
                      Padding(
                        padding: EdgeInsets.fromLTRB(Dimens.small, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email",
                            style: robotoMedium.copyWith(
                              fontSize: appFontSize.mediumFontSize,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimens.small),
                      //email
                      InputText(
                        controller: gmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter gmail";
                          } else if (!value.endsWith("@gmail.com")) {
                            return "Please enter a valid gmail";
                          }
                          return null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "Email",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 20,
                            child: SvgPicture.asset(
                              ICONS.email,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        appFontSize: appFontSize,
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: Dimens.large),
                      //label
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(Dimens.small, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password",
                            style: robotoMedium.copyWith(
                              fontSize: appFontSize.mediumFontSize,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimens.small),
                      //password
                      InputText(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          } else if (value.length < 7) {
                            return "at least enter 6 characters";
                          } else if (value.length > 13) {
                            return "maximum characters is 13";
                          }
                          return null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "Password",
                        obscureText: _isObsecured,
                        suffixIcon: IconButton(
                          color: colorScheme.onPrimary,
                          onPressed: () {
                            setState(() {
                              _isObsecured = !_isObsecured;
                            });
                          },
                          icon: Icon(
                            _isObsecured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 20,
                            child: SvgPicture.asset(
                              ICONS.password,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        appFontSize: appFontSize,
                        colorScheme: colorScheme,
                      ),

                      const SizedBox(height: Dimens.small),
                      //forget password
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0, 0, Dimens.small, 0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Forget Password?",
                            style: robotoMedium.copyWith(
                              color: colorScheme.secondary,
                              fontSize: appFontSize.mediumFontSize,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimens.large),

                      CustomButton(
                        appFontSize: appFontSize,
                        title: "Login",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            print(gmailController.text);
                            print(passwordController.text);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.08),

              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, RouteNames.registerPage),
                child: Text.rich(TextSpan(
                    text: "Not a member?",
                    style: robotoMedium.copyWith(
                      fontSize: appFontSize.largeFontSize,
                    ),
                    children: [
                      TextSpan(
                        text: " Register",
                        style: robotoMedium.copyWith(
                          fontSize: appFontSize.largeFontSize,
                          color: colorScheme.secondary,
                        ),
                      )
                    ])),
              ),

              Image.asset(
                IMAGES.logo,
                width: size.width / 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

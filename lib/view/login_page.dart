import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/model/colors_themes/color_palette.dart';
import '../model/cubit/app_cubit.dart';
import '../model/cubit/app_states.dart';
import '../model/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool isChecked = false;
  Color color = AppTheme.buttonColor;
  bool hide = true;
  togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            hide = !hide;
          });
        },
        icon: hide == true
            ? const Icon(Icons.visibility_off_outlined)
            : const Icon(Icons.visibility_outlined));
  }

  GlobalKey<FormState> logForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  //Navigator.of(context, rootNavigator: true).pop(context);
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Image.asset(
                    "assets/images/Logo.jpg",
                    height: 20,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: logForm,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        headline(text: "Login"),
                        const SizedBox(
                          height: 5,
                        ),
                        normalText(text: "Please login to find your dream job"),
                        const SizedBox(
                          height: 30,
                        ),
                        textField(
                            obscureText: false,
                            controller: AppCubit.get(context).name,
                            hintText: "Name",
                            prefix: const Icon(Icons.person_outline),
                            validator: (name) => name!.length < 3
                                ? "name should be more than 3 characters"
                                : null),
                        const SizedBox(
                          height: 25,
                        ),
                        textField(
                            obscureText: hide,
                            controller: AppCubit.get(context).password,
                            hintText: "Password",
                            prefix: const Icon(Icons.lock_outline),
                            suffix: togglePassword(),
                            validator: (password) => password!.length < 8
                                ? "Password must be at least 8 characters"
                                : null),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                activeColor: AppTheme.buttonColor,
                                value: isChecked,
                                onChanged: (changed) {
                                  setState(() {
                                    isChecked = changed!;
                                  });
                                }),
                            const Text(
                              "Remember me",
                              style: TextStyle(fontSize: 15),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            textButton(
                                text: "Forgot Password?",
                                onPressed: () {
                                  // Navigator.pushNamed(
                                  //     context, AppRouter.resetPassword);
                                })
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            normalText(text: "Don't have an account"),
                            textButton(
                                text: "Register",
                                onPressed: () {
                                  // Navigator.pushNamed(
                                  //     context, AppRouter.createAccount);
                                })
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultButton(
                            text: "Login",
                            onPressed: () {
                              logForm.currentState!.validate();
                              context
                                  .read<AppCubit>()
                                  .logIn(); // Navigator.pushNamed(
                              //     context, AppRouter.homeScreen);
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.grey.withOpacity(0.3),
                              height: 2,
                              width: 60,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            normalText(text: "Or Login With Account"),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              color: Colors.grey.withOpacity(0.3),
                              height: 2,
                              width: 60,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GoogleAuthButton(
                                onPressed: () {},
                                text: "Google",
                                style: const AuthButtonStyle(
                                    buttonType: AuthButtonType.icon,
                                    iconType: AuthIconType.secondary,
                                    textStyle: TextStyle(color: Colors.black)),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              FacebookAuthButton(
                                onPressed: () {},
                                text: "Facebook",
                                style: const AuthButtonStyle(
                                  buttonType: AuthButtonType.icon,
                                  iconType: AuthIconType.secondary,
                                ),
                              ),
                            ]),
                      ]),
                ),
              ),
            ));
      },
    );
  }
}

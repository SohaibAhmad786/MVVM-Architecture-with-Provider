import 'package:flutter/material.dart';
import 'package:mvvm/res/Components/round_button.dart';
import 'package:mvvm/utils/Routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

ValueNotifier<bool> _valueNotifier = ValueNotifier<bool>(true);
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
FocusNode emailFocusNode = FocusNode();
FocusNode passwordFocusNode = FocusNode();

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.mail_outline),
            ),
            focusNode: emailFocusNode,
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(
                  context, emailFocusNode, passwordFocusNode);
            },
          ),
          ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (context, value, child) {
              return TextFormField(
                controller: _passwordController,
                obscureText: _valueNotifier.value,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _valueNotifier.value = !_valueNotifier.value;
                      },
                      icon: _valueNotifier.value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    )),
                focusNode: passwordFocusNode,
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          Consumer<AuthViewModel>(
            builder: (context, value, child) {
              return RoundedButton(
                  title: "Login",
                  isLoading: value.loading,
                  callBack: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage("Enter Email", context);
                    } else if (_passwordController.text.isEmpty) {
                      Utils.flushBarErrorMessage("Enter Password", context);
                    } else if (_passwordController.text.length < 6) {
                      Utils.flushBarErrorMessage(
                          "Password length is less than 6", context);
                    } else {
                      Map data = {
                        "email": _emailController.text.toString(),
                        "password": _passwordController.text.toString()
                      };
                      value.loginApi(context, data);
                      print("Login Succesfull");
                    }
                  });
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.signUp);
            },
            child: const Text(
              "Don't have an account? Sign Up",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

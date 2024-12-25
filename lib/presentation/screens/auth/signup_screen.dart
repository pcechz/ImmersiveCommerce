import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immersive_commerce/presentation/utils/colors.dart';
import 'package:immersive_commerce/presentation/utils/widget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../viewmodels/auth_viewmodel.dart';

class SignupScreen extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: context.height(),
          color: context.scaffoldBackgroundColor,
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              text("Signup", textColor: textPrimaryColor,  fontSize: 24),
              SizedBox(height: 16),
              EditText(
                mController: nameController,
                text: "Full Name",
                isPassword: false,
              ),
              SizedBox(height: 16),
              EditText(
                mController: emailController,
                text: "Email Address",
                isPassword: false,
              ),
              SizedBox(height: 16),
              EditText(
                mController: passwordController,
                text: "Password",
                isSecure: true,
              ),
              SizedBox(height: 20),
              authState.isLoading
                  ? CircularProgressIndicator()
                  : AppButtons(
                onPressed: () {
                  ref.read(authProvider.notifier).register(
                      emailController.text,
                      passwordController.text,
                      nameController.text, context);


                },
                textContent: "Sign up",
              ),

              //
              if (authState.error != null)
                Text(authState.error!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  text("Already have an account?", textColor: textColorSecondary),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(onTap: (){
                    Navigator.pushNamed(context, '/login');
                  }, child: text("Login")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

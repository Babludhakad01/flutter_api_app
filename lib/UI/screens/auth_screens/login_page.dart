import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtub_flutter_project/core/navigation/navigation_service.dart';
import 'package:youtub_flutter_project/logic/Blocs/Auth/auth_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/Auth/auth_event.dart';
import 'package:youtub_flutter_project/logic/Blocs/Auth/auth_state.dart';
import 'package:youtub_flutter_project/routes/app_router.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login Successfully")));
          NavigationService.pushReplacementNamed(AppRoutes.posts);

        } else if (state.status == AuthStatus.failure) {
          // print(state.error);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? "Login failed")),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Login Page",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            elevation: 2,
            backgroundColor: Colors.orangeAccent,
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orangeAccent,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Welcome Text
                  const Text(
                    "Welcome Back 👋",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Login to Continue",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 40),

                  //Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.orangeAccent,
                      ),
                      labelText: "Email Address",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Password Field
                  TextField(
                    controller: pwdController,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Login Button
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(
                        LoginRequest(
                          email: emailController.text,
                          password: pwdController.text,
                        ),
                      );
                    },

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orangeAccent, Colors.deepOrange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),

                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orangeAccent.withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

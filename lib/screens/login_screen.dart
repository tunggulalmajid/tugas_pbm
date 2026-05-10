import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tugas_pbm/DTO/login_request.dart';
import 'package:tugas_pbm/providers/auth_provider.dart';
import 'package:tugas_pbm/utils/app_routes.dart';
import 'package:tugas_pbm/widgets/w_button.dart';
import 'package:tugas_pbm/widgets/w_failed_dialog.dart';
import 'package:tugas_pbm/widgets/w_success_dialog.dart';
import 'package:tugas_pbm/widgets/w_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void handlerLogin(LoginRequest loginParams) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      bool success = await authProvider.login(loginParams);

      if (success && mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => WSuccessDialog(
            message: "Login Berhasil",
            onOkPressed: () {
              Navigator.pop(c);
            },
          ),
        );
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dashboard,
            (route) => false,
          );
        }
      } else if (mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => WFailedDialog(
            message: "Login Gagal",
            onOkPressed: () {
              Navigator.pop(c);
            },
          ),
        );
      }
    } catch (e) {
      log("Error pada UI Login: $e");
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade800,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      letterSpacing: 5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    WTextFormFieldForm(
                      hintText: "Username",
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    WTextFormFieldForm(
                      hintText: "Password",
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    WButton(
                      text: "Login",
                      textColor: Colors.indigo.shade800,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          LoginRequest loginParams = LoginRequest(
                            username: usernameController.text,
                            password: passwordController.text,
                          );
                          handlerLogin(loginParams);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

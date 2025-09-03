import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // TODO: Validação mais efetiva, melhorar feedback ao usuário. Criar UserProfile no firestore com uid do novo usuário
  void _register(UserProvider provider) async {
    if (_formKey.currentState!.validate()) {
      await provider.register(_emailController.text, _passwordController.text);

      if (provider.errorMessage == null) {
        Navigator.pushNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(provider.errorMessage!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: userProvider.isLoading ? CircularProgressIndicator() : Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: _emailController,
                  label: "Email",
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    const String pattern =
                        "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}\$";
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return "The email provided is invalid";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                CustomTextFormField(
                  controller: _passwordController,
                  label: "Password",
                  icon: Icons.key,
                  isPassword: true,
                  validator: (value) {
                    value = value?.trim();
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    if (value.length < 6) {
                      return "The password must be atleast 6 digits long";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () => _register(userProvider),
                  child: Text("Enviar"),
                ),

                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/login"),
                  child: Text("Já tenho uma conta. Entrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

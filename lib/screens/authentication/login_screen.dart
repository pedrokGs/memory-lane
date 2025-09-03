import 'package:flutter/material.dart';
import 'package:memory_lane/providers/user_provider.dart';
import 'package:memory_lane/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // TODO: Validação mais efetiva, melhorar feedback ao usuário. Carregar UserProfile
  void _login(UserProvider provider) async {
    if (_formKey.currentState!.validate()) {
      await provider.login(_emailController.text, _passwordController.text);

      if (provider.errorMessage == null) {
        Navigator.pushNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(provider.errorMessage!)),
        );
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
          child:
              userProvider.isLoading
                  ? CircularProgressIndicator()
                  : Form(
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
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        ElevatedButton(
                          onPressed: () => _login(userProvider),
                          child: Text("Enviar"),
                        ),

                        const SizedBox(height: 24),
                        TextButton(
                          onPressed:
                              () => Navigator.pushNamed(context, "/register"),
                          child: Text("Não tenho uma conta. Cadastrar"),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}

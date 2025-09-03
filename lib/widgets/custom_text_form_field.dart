import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String label;
  final IconData? icon;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.label = "",
    this.icon,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscured;

  @override
  void initState() {
    super.initState();
    obscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = widget.controller;
    final bool isPassword = widget.isPassword ?? false;
    final String label = widget.label ?? "";
    final IconData? icon = widget.icon;
    final FormFieldValidator<String>? validator = widget.validator;

    return TextFormField(
      controller: controller,
      obscureText: obscured,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon:
            isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscured = !obscured;
                    });
                  },
                  icon: Icon(obscured ? Icons.visibility : Icons.visibility_off),
                )
                : null,
        label: Row(children: [if (icon != null) Icon(icon), Text(label)]),
      ),
    );
  }
}

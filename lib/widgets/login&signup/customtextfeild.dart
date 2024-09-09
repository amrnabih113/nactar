import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {
  const CustomTextFeild({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isPassword;

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool showPassword = false;

  // Updated to accept nullable string
  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return '${widget.label} cannot be empty';
    }

    if (widget.label == 'Email') {
      bool emailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
              .hasMatch(value);
      if (!emailValid) {
        return 'Enter a valid email';
      }
    }

    if (widget.isPassword && value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null; // Return null if validation passes
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? !showPassword : false,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff7C7C7C),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: widget.hint,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      showPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  )
                : null,
          ),
          // Pass validateInput as the validator function
          validator: validateInput,
        ),
      ],
    );
  }
}

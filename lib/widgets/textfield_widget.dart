import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String ? hintText;
  final TextEditingController ? controller;
  final String? Function(String?)? validator;
  final bool? isPassword;
  const CustomTextField({super.key, this.controller, this.hintText, this.validator, this.isPassword = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: showPass,
      decoration: InputDecoration(
        hintText: widget.hintText,
        
        suffixIcon: !widget.isPassword!  ? null : IconButton(onPressed: (){
          showPass = !showPass;
          setState(() {
            
          });
        }, icon: showPass ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)) 
      ),
      
    );
  }
}
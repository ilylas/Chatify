import 'package:flutter/material.dart';

class CustomTExtFormField extends StatelessWidget{
  final Function(String) onSaved;

  final String regEx;
  final String hintText;
  final bool obscureText;

  const CustomTExtFormField({super.key, required this.onSaved, required this.regEx, required this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      onSaved: (value)=> onSaved(value!),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.blue),
      obscureText: obscureText,
      validator: (value){
        return RegExp(regEx).hasMatch(value!) ? null : 'Enter a valid value';
      },
      decoration: InputDecoration(
          fillColor: Color.fromRGBO(30, 29, 37, 1.0),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.white54
          )
      ),
    );
  }





}
import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class FGBPTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool autofocus;
  final bool isPassword;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final bool? enableInteractiveSelection;

  const FGBPTextField({
    Key? key,
    this.label,
    this.hintText,
    this.controller,
    this.maxLength,
    this.textInputType,
    this.onChanged,
    this.textInputAction,
    this.onEditingComplete,
    this.enableInteractiveSelection,
    this.autofocus = false,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableInteractiveSelection: enableInteractiveSelection,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      autofocus: autofocus,
      style: FGBPTextTheme.text2Bold,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: FGBPColors.Black2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: FGBPColors.Black2),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: FGBPColors.Black2, width: 1.0),
        ),
        counterText: "",
        fillColor: Colors.transparent,
        filled: true,
        hintStyle: FGBPTextTheme.text2.copyWith(color: FGBPColors.Black3),
        floatingLabelStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
    );
  }
}

class FGBPTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool autofocus;
  final bool isPassword;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final bool? enableInteractiveSelection;
  final bool readOnly;

  const FGBPTextFormField({
    Key? key,
    this.label,
    this.hintText,
    this.controller,
    this.maxLength,
    this.textInputType,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.onEditingComplete,
    this.enableInteractiveSelection,
    this.autofocus = false,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      enableInteractiveSelection: enableInteractiveSelection,
      textInputAction: textInputAction,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      autofocus: autofocus,
      style: FGBPTextTheme.text2Bold,
      onEditingComplete: onEditingComplete,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: FGBPColors.Black2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: FGBPColors.Black2),
        ),
        counterText: "",
        fillColor: Colors.transparent,
        filled: true,
        hintStyle: FGBPTextTheme.text2.copyWith(color: FGBPColors.Black3),
        floatingLabelStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
      validator: validator,
    );
  }
}

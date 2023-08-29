import 'package:flutter/material.dart';
import 'package:izam_task/theme/styles.dart';

class CustomTextFormField extends StatefulWidget {
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool? hasHorizontalMargin;
  final bool? enabled;
  final String? initialValue;
  final String? hintTxt;
  final TextInputType? inputData;
  final bool? isPassword;
  final String? Function(String?)? validation;
  final Function(String)? onChangedFunc;
  final Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final Function()? onTaped;
  final bool? suffixIconIsImage;
  final Widget? prefix;
  final Widget? suffixIcon;
  final String? suffixIconImagePath;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefixIcon;
  final bool? prefixIconIsImage;
  final String? prefixIconImagePath;
  final String? labelText;
  final bool? expands;
  final bool? enableBorder;
  final FocusNode? focusNode;
  final OutlineInputBorder? disabledBorder;

  final TextEditingController controller;
  CustomTextFormField(
      {this.hintTxt,
      this.inputData,
      this.disabledBorder,
      this.hasHorizontalMargin = true,
      this.isPassword = false,
      this.validation,
      this.onFieldSubmitted,
      this.onTaped,
      this.onSaved,
      this.onChangedFunc,
      this.enableBorder = true,
      this.initialValue,
      this.expands = false,
      this.suffixIcon,
      this.maxLength,
      this.enabled = true,
      this.maxLines,
      this.prefixIconIsImage = false,
      this.suffixIconIsImage = false,
      this.prefixIcon,
      this.labelText,
      required this.controller,
      this.suffixIconImagePath,
      this.prefixIconImagePath,
      this.prefix,
      this.hintStyle,
      this.textStyle,
      this.focusNode});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obsecureText = true;
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode!.dispose();

    super.dispose();
  }

  Widget _buildTextFormField() {
    return TextFormField(
      expands: widget.expands ?? false,
      controller: widget.controller,
      enabled: widget.enabled,
      maxLines: widget.maxLines ?? 1,
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      initialValue: widget.initialValue,
      textDirection: TextDirection.ltr,
      style: widget.textStyle ??
          const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Styles.textFieldColor,
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusColor: Styles.onPrimaryColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        prefix: widget.prefix,
        hintText: widget.hintTxt,
        errorStyle: const TextStyle(
          fontSize: 11.0,
          color: Styles.onDangerColor,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Styles.textFieldColor),
        ),
        disabledBorder: widget.disabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: _focusNode!.hasFocus
                      ? Styles.primaryColor
                      : Styles.textFieldColor),
            ),
        hintStyle: widget.hintStyle ??
            TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
                fontWeight: FontWeight.w400),
      ),
      keyboardType: widget.inputData,
      obscureText: widget.isPassword ?? false ? _obsecureText : false,
      validator: widget.validation,
      onChanged: widget.onChangedFunc,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      textAlign: TextAlign.left,
      onTap: widget.onTaped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          margin: EdgeInsets.symmetric(
              horizontal: widget.hasHorizontalMargin ?? false
                  ? constraints.maxWidth * 0.07
                  : 0),
          child: _buildTextFormField());
    });
  }
}

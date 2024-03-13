import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomLabelledTextField extends StatelessWidget {
  final int? length;
  final int? maxLines;
  final int? minLines;
  final String? label;
  final String? hintText;
  final bool? hasBorder;
  final bool? isEnabled;
  final bool? isExpanded;
  final bool? maxLineEnforced;
  final bool? isDigitOnlyWithNoDecimal;
  final Widget? icon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String value)? onTextChanged;
  final Function(String value)? onFieldSubmitted;

  const CustomLabelledTextField({
    super.key,
    this.length,
    this.maxLines,
    this.minLines,
    this.label,
    this.hintText,
    this.hasBorder,
    this.isEnabled,
    this.isExpanded,
    this.maxLineEnforced,
    this.isDigitOnlyWithNoDecimal,
    this.icon,
    this.prefix,
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.inputType,
    this.textInputAction,
    this.controller,
    this.validator,
    this.onTextChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        if (onTextChanged != null) {
          onTextChanged!(value);
        }
      },
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted!(value);
        }
      },
      maxLengthEnforcement:
          maxLineEnforced == true ? MaxLengthEnforcement.enforced : null,
      keyboardType: inputType ?? TextInputType.text,
      maxLength: length,
      controller: controller,
      textInputAction: textInputAction ?? TextInputAction.next,
      focusNode: focusNode,
      enabled: isEnabled == false ? false : true,
      maxLines: isExpanded == true ? null : maxLines,
      minLines: isExpanded == true ? null : minLines,
      inputFormatters: isDigitOnlyWithNoDecimal == true
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
        icon: icon,
        prefix: prefix,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: label != null ? Text(label!) : null,
        hintText: hintText,
        floatingLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        contentPadding: maxLines != null
            ? const EdgeInsets.symmetric(vertical: 10, horizontal: 16)
            : const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          borderSide: BorderSide(
            width: hasBorder == false ? 0 : 1,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}

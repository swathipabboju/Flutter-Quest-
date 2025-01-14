import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextformfield extends StatelessWidget {
  const PhoneTextformfield({
    super.key,
    required this.hintText,
    required this.controller,
     this.keyboardInputType,
     this.obscureText,
    required this.node,
     this.action,
     this.onEditingComplete,
    this.globalKey,
    this.prefixIcon,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
    this.autofocus,
    required this.errorMessage,
    this.TextLength,
    this.filterPattern, this.inputFormatter,
  });
  final String hintText, errorMessage;
  final TextEditingController controller;
  final TextInputType? keyboardInputType;
  final bool? obscureText;
  final FocusScopeNode node;
  final TextInputAction? action;
  final VoidCallback? onEditingComplete;
  final GlobalKey? globalKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool? autofocus;
  final void Function()? onTap;
  final int? TextLength;
  final Pattern? filterPattern;
  final List<TextInputFormatter>? inputFormatter;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FocusScope(
        node: node,
        child: Form(
          key: globalKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: TextFormField(
              autofocus: autofocus ?? false,
              obscureText: obscureText ?? false,
              textInputAction: TextInputAction.done,
              onEditingComplete: onEditingComplete,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: hintText,
              ),
              validator: (value) {
                if (value!.isEmpty)
                  return errorMessage;
                else
                  return "";
              },
              inputFormatters: inputFormatter,
              keyboardType: keyboardInputType,
            ),
          ),
        ),
      ),
    );
  }
}

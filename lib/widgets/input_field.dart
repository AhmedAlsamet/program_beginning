import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.isRequired,
    this.readOnly = false,
    this.isNumber = false,
    this.obscureText = false,
    this.withBorder = true,
    this.enabled = true,
    this.autoFocus = false,
    this.textDirection = TextDirection.rtl,
    required this.node,
    required this.keyboardType,
    required this.controller,
    this.label,
    // this.additionalCondetions,
    this.hint,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.maxLines,
    this.maxLength,
    this.suffix,
    this.textForErrorMessage,
    this.redColor,
    this.additionsalCondection = false,
  });

  final bool isRequired;
  final bool? readOnly;
  final bool enabled;
  final bool isNumber;
  final bool obscureText;
  final bool? additionsalCondection;
  final bool withBorder;
  final bool autoFocus;
  final FocusNode node;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? textForErrorMessage;
  final int? maxLines;
  final TextDirection? textDirection;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onEditingComplete;
  final Widget? suffix;
  final Color? redColor;
  // final Map? additionalCondetions;

  // i mean the condetion will be the key and text will be the value
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      enabled: enabled,
      autofocus: autoFocus,
      onTapOutside: onTapOutside,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      readOnly: readOnly!,
      obscureText: obscureText,
      textDirection: textDirection,
      contextMenuBuilder: (context, editableTextState) => const SizedBox(),
      validator: (v) {
        if (isRequired) {
          if (v!.trim() == "") {
            return "قيمة فارغة";
          }
          if (v.trim().contains("drop") ||
              v.trim().contains("alter") ||
              v.trim().contains("--") ||
              v.trim().contains(" delete ") ||
              v.trim().contains(" rem ") ||
              v.trim().contains(" and ") ||
              v.trim().contains(" or ") ||
              v.trim().contains(" in ")) {
            return "قيمة خاطئة";
          }
          if (isNumber) {
            if (num.tryParse(v) == null) {
              return "يرجى إدخال أرقام فقط في هذه الخانة";
            }
            if (num.tryParse(v)! < 0) {
              return "لا يمكن ان تكون القيمة سالبة";
            }
          }
          if (additionsalCondection!) {
            return textForErrorMessage;
          }
          return null;
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChanged,
      focusNode: node,
      keyboardType: keyboardType,
      controller: controller,
      style: Theme.of(context).textTheme.displaySmall,
      // style: const TextStyle(color: Colors.black),
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          suffixIcon: suffix,
          counter: const SizedBox(),
          errorStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: redColor),
          enabledBorder: withBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(20))
              : null,
          focusedBorder: withBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(20))
              : null,
          label: label == null ? null : Text(label!),
          labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w500,
                // for label TextFailed
              ),
          hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w500,
                // for label TextFailed
              ),
          hintText: hint ?? ""),
    );
  }
}

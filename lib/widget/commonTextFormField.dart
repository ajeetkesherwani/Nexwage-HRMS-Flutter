import 'package:flutter/material.dart';
import '../util/color/app_colors.dart';

class CommonTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? counterText;

  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Widget? customSuffix;

  final String? Function(String?)? validator;
  final String? regexPattern;
  final String? regexErrorMessage;

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final Function(String?)? onSaved;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool obscureText; // 👈 use this to enable password field
  final bool isDisabled;
  final bool readOnly;
  final bool autofocus;

  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;

  const CommonTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.counterText,
    this.prefixIcon,
    this.suffixIcon,
    this.customSuffix,
    this.validator,
    this.regexPattern,
    this.regexErrorMessage = 'Invalid format',
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.onSaved,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.obscureText = false, // 👈 default false
    this.isDisabled = false,
    this.readOnly = false,
    this.autofocus = false,
    this.height = 50.0,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.borderRadius = 12.0,
  });

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  String? errorText;

  late FocusNode _focusNode;
  bool isFocused = false;

  bool _obscureText = false; // 👈 local state

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _obscureText = widget.obscureText; // 👈 init from widget

    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _regexValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    if (widget.regexPattern != null) {
      final regExp = RegExp(widget.regexPattern!);
      if (!regExp.hasMatch(value.trim())) {
        return widget.regexErrorMessage;
      }
    }
    return null;
  }

  String? _getValidator(String? value) {
    if (widget.validator != null) {
      final result = widget.validator!(value);
      if (result != null) return result;
    }
    return _regexValidator(value);
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
    errorText != null
        ? Colors.red
        : isFocused
        ? ColorResource.button1
        : (widget.borderColor ?? const Color(0xffDBDBDB));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        const SizedBox(height: 5),

        /// TEXT FIELD
        // Container(
        //   height: widget.height,
        //   decoration: BoxDecoration(
        //     color: widget.backgroundColor,
        //     border: Border.all(color: effectiveBorderColor, width: 1.2),
        //     borderRadius: BorderRadius.circular(widget.borderRadius),
        //   ),
        //   child: TextFormField(
        //     focusNode: _focusNode,
        //     cursorColor: ColorResource.primaryColor,
        //     controller: widget.controller,
        //     keyboardType: widget.keyboardType,
        //     textInputAction: widget.textInputAction,
        //     maxLines: widget.maxLines,
        //     minLines: widget.minLines,
        //     maxLength: widget.maxLength,
        //     obscureText: _obscureText, // 👈 IMPORTANT
        //     enabled: !widget.isDisabled,
        //     readOnly: widget.readOnly || widget.isDisabled,
        //     autofocus: widget.autofocus,
        //     onTap: widget.isDisabled ? () {} : widget.onTap,
        //     onFieldSubmitted:
        //     widget.isDisabled ? null : widget.onFieldSubmitted,
        //     onSaved: widget.onSaved,
        //     onChanged: (value) {
        //       setState(() {
        //         errorText = _getValidator(value);
        //       });
        //       widget.onChanged?.call(value);
        //     },
        //     style: TextStyle(
        //       fontSize: 14,
        //       color: widget.isDisabled
        //           ? Colors.grey.shade600
        //           : Colors.black,
        //     ),
        //     decoration: InputDecoration(
        //       hintText: widget.hintText,
        //       hintStyle: const TextStyle(color: Color(0xff6B7280)),
        //       helperText: widget.helperText,
        //       counterText: widget.counterText ?? "",
        //       prefixIcon: widget.prefixIcon != null
        //           ? Icon(
        //         widget.prefixIcon,
        //         size: 20,
        //         color: widget.isDisabled
        //             ? Colors.grey.shade500
        //             : Colors.black54,
        //       )
        //           : null,
        //
        //       /// 👁 PASSWORD TOGGLE ICON
        //       suffixIcon: widget.obscureText
        //           ? IconButton(
        //         icon: Icon(
        //           _obscureText
        //               ? Icons.visibility_off_outlined
        //               : Icons.visibility_outlined,
        //         ),
        //         onPressed: () {
        //           setState(() {
        //             _obscureText = !_obscureText;
        //           });
        //         },
        //       )
        //           : widget.customSuffix ?? widget.suffixIcon,
        //
        //       border: InputBorder.none,
        //       contentPadding: const EdgeInsets.symmetric(
        //         horizontal: 14,
        //         vertical: 14,
        //       ),
        //     ),
        //   ),
        // ),
        Container(
          height: widget.maxLines! > 1 ? null : widget.height, // 👈 FIX
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: Border.all(color: effectiveBorderColor, width: 1.2),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: TextFormField(
            focusNode: _focusNode,
            cursorColor: ColorResource.primaryColor,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            minLines: widget.maxLines! > 1 ? widget.maxLines : widget.minLines, // 👈 FIX
            maxLength: widget.maxLength,
            obscureText: _obscureText,
            enabled: !widget.isDisabled,
            readOnly: widget.readOnly || widget.isDisabled,
            autofocus: widget.autofocus,
            onTap: widget.isDisabled ? () {} : widget.onTap,
            onFieldSubmitted:
            widget.isDisabled ? null : widget.onFieldSubmitted,
            onSaved: widget.onSaved,
            onChanged: (value) {
              setState(() {
                errorText = _getValidator(value);
              });
              widget.onChanged?.call(value);
            },
            style: TextStyle(
              fontSize: 14,
              color: widget.isDisabled
                  ? Colors.grey.shade600
                  : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Color(0xff6B7280)),
              helperText: widget.helperText,
              counterText: widget.counterText ?? "",
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                widget.prefixIcon,
                size: 20,
                color: widget.isDisabled
                    ? Colors.grey.shade500
                    : Colors.black54,
              )
                  : null,

              suffixIcon: widget.obscureText
                  ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : widget.customSuffix ?? widget.suffixIcon,

              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),

        /// ERROR TEXT
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
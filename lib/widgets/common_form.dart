import 'package:dicoding_submission/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonForm extends StatefulWidget {
  const CommonForm({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.showVisibilityIcon = true,
  });

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool showVisibilityIcon;

  @override
  _CommonFormState createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscured,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: tsTextRegularWhite,
          suffixIcon: widget.showVisibilityIcon
              ? IconButton(
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            icon: Icon(
              _isObscured ? Icons.visibility_off : Icons.visibility,
              color: primaryText,
            ),
          )
              : null, //
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          filled: true,
          fillColor: bgForm,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: bgButton,
            ),
          ),
        ),
        style: tsTextRegularWhite,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
      ),
    );
  }
}

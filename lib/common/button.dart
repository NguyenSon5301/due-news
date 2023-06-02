import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    required this.buttonLabel,
    required this.color,
    super.key,
  });

  final Function()? onPressed;
  final String buttonLabel;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 42,
          child: Text(
            buttonLabel,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

/// This are styles used in our textfield
/// optional:create a class to hold your styles
//import material design
/// to use it in a widget just call the name of the eg: decoration: kTextFieldDecoration
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter password',
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
);

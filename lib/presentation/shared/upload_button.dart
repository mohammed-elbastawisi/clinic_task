import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  const UploadButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).secondaryHeaderColor,
        ),
        child: Text(title),
        onPressed: onPressed,
      ),
    );
  }
}

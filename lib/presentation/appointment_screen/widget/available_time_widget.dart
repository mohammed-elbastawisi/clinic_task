import 'package:flutter/material.dart';

class AvailableTimeWidget extends StatelessWidget {
  final String availableTime;
  final Function()? onTap;
  const AvailableTimeWidget({
    Key? key,
    required this.availableTime,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        width: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          availableTime,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      onTap: onTap,
    );
  }
}

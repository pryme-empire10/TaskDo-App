import 'package:flutter/material.dart';

class ResetContainer extends StatelessWidget {
  final Function() onTap;
  ResetContainer({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.cancel_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

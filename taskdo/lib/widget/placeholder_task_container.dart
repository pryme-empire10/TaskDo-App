import 'package:flutter/material.dart';

class PlaceholderTaskContainer extends StatelessWidget {
  const PlaceholderTaskContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            ' Ready to start? ',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          Image.asset(
            'assets/images/thumbs.png',
            color: Colors.grey,
          ),
          const Text(
            'Add some tasks',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

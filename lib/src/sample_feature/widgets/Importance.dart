import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.importance});
  final int importance;

  @override
  Widget build(BuildContext context) {
    switch (importance) {
      case 1:
        return const Text("терміново важливо");
      case 2:
        return const Text('не терміново важливо');
      case 3:
        return const Text('терміново не важливо');
      case 4:
        return const Text('не терміново не важливо');

      default:
        return const SizedBox(
          height: 0,
        );
    }
  }
}

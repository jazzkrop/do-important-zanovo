import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.importance});
  final int importance;

  @override
  Widget build(BuildContext context) {
    switch (importance) {
      case 1:
        return Text("терміново важливо");
      case 2:
        return Text('не терміново важливо');
      case 3:
        return Text('терміново не важливо');
      case 4:
        return Text('не терміново не важливо');

      default:
        return SizedBox(
          height: 0,
        );
    }
  }
}

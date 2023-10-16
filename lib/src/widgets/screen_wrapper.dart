import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        SizedBox(
          height: double.infinity,
          child: child,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 70),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              "do important",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}

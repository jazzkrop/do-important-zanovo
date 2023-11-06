import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper(
      {super.key, required this.child, required this.onTap, this.onLongTap});
  final Widget child;
  final Function onTap;
  final Function? onLongTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Stack(children: [
          SizedBox(
            width: double.infinity,
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
              onPressed: () {
                onTap();
              },
              onLongPress: () {
                if (onLongTap != null) {
                  onLongTap!();
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}

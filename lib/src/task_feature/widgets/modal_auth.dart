import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:do_important_zanovo/src/core/services/db_constants.dart';
import 'package:do_important_zanovo/src/core/services/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModalAuth {
  bool loggedIn = false;

  _onClosePressed() async {
    // SystemNavigator.pop();
    await FirebaseAuth.instance.signOut();
  }

  _sign_in_google_on_press(context) async {
    var user = await signInWithGoogle();
    // create if no user in database
    var db = FirebaseFirestore.instance;
    if (user.user == null) {
      return;
    }
    var userData = {
      "id": user.user!.uid,
      "name": user.user!.displayName,
      "email": user.user!.email,
    };
    await db
        .collection(DatabasePaths.users)
        .doc(userData["id"])
        .set(userData, SetOptions(merge: true));
    loggedIn = true;
    Navigator.of(context).pop();
    // print(user.user?.uid);
  }

  _checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final internetConnection = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.vpn;
    return internetConnection;
  }

  main(context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      return;
    }
    bool internetConnection = await _checkConnection();
    // ignore: use_build_context_synchronously
    showDialog<bool>(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          'Вхід у акаунт',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 32),
                      internetConnection
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                    minimumSize: const Size.fromHeight(40)),
                                onPressed: () {
                                  _sign_in_google_on_press(context);
                                },
                                label: const Text("Sign in with Google"),
                                icon: Image.asset(
                                  'assets/images/btn_google_light_normal_xhdpi.9.png',
                                  fit: BoxFit.cover,
                                  width: 28,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      minimumSize: const Size.fromHeight(40)),
                                  onPressed: () async {
                                    var newInternetConnection =
                                        await _checkConnection();
                                    // кнопка. тепер є інтернет
                                    setState(() {
                                      internetConnection =
                                          newInternetConnection;
                                    });
                                  },
                                  child: const Text(
                                      'Тепер є доступ до Інтернету')),
                            ),
                      // ignore: prefer_const_constructors
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: FilledButton.tonal(
                          style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(40)),
                          onPressed: _onClosePressed,
                          child: const Text('Close'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                );
              },
            )).whenComplete(() {
      if (loggedIn == false) {
        SystemNavigator.pop();
      }
    });
  }
}

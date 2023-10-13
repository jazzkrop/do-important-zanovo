import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:do_important_zanovo/src/core/services/google_sign_in.dart';
import 'package:do_important_zanovo/src/widgets/screen_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  SampleItemListView({super.key});

  static const routeName = '/';

  List<SampleItem> items = [
    SampleItem(
      id: '1',
      createdAt: DateTime.now(),
      importance: 1,
      title: 'УМ підготуватись до тесту',
      reason: 'якісний пастор гарно говорить',
    ),
    SampleItem(
      id: '2',
      createdAt: DateTime.now().add(const Duration(hours: 2)),
      importance: 2,
      title: 'Д дочитати ХНС',
      reason: 'це круто',
    ),
    SampleItem(
      id: '3',
      createdAt: DateTime.now().add(const Duration(hours: 1)),
      importance: 3,
      title: 'З син червяк',
      reason: 'питає в мами',
    ),
    SampleItem(
      id: '4',
      createdAt: DateTime.now().add(const Duration(hours: 1)),
      importance: 4,
      title: 'О душ',
      reason: 'бути чисним це класно',
    ),
  ];

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  @override
  void initState() {
    super.initState();

    var internetConnection;

    if (FirebaseAuth.instance.currentUser != null) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      internetConnection = await _checkConnection();
      // ignore: use_build_context_synchronously
      bool? dialogResult = await showDialog<bool>(
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
                                  onPressed: _sign_in_google_on_press,
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
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
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
              ));
      if (dialogResult == null) {
        SystemNavigator.pop();
      }
    });
  }

  _onClosePressed() async {
    // SystemNavigator.pop();
    await FirebaseAuth.instance.signOut();
  }

  _sign_in_google_on_press() async {
    var user = await signInWithGoogle();
    // create if no user in database
    // print(user.user?.uid);
  }

  _checkConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final internetConnection = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.vpn;
    return internetConnection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ScreenWrapper(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          child: Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.question_mark_rounded),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.settings_sharp))
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  restorationId: 'sampleItemListView',
                  itemCount: widget.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = widget.items[index];

                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 4.0,
                                style: BorderStyle.solid),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ), //
                          child: Column(
                            children: [
                              Text(item.title),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 200,
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChnageLanguageScreen extends StatefulWidget {
  const ChnageLanguageScreen({super.key});

  @override
  State<ChnageLanguageScreen> createState() => _ChnageLanguageScreenState();
}

class _ChnageLanguageScreenState extends State<ChnageLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Localization"),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            title: Text('message'.tr),
            subtitle: Text('name'.tr),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.updateLocale(const Locale('en', 'US'));
                  },
                  child: const Text('English'),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    Get.updateLocale(const Locale('ur', 'PK'));
                  },
                  child: const Text('Urdu'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodiezone/provider/theme_change_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeScreen extends StatelessWidget {
  const ChangeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChnager = Provider.of<ThemeChangeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("App Theme"),
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text("Light theme"),
            value: ThemeMode.light,
            groupValue: themeChnager.themeMode,
            onChanged: themeChnager.setTheme,
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Dark theme"),
            value: ThemeMode.dark,
            groupValue: themeChnager.themeMode,
            onChanged: themeChnager.setTheme,
          ),
          RadioListTile<ThemeMode>(
            title: const Text("System mode"),
            value: ThemeMode.system,
            groupValue: themeChnager.themeMode,
            onChanged: themeChnager.setTheme,
          )
        ],
      ),
    );
  }
}

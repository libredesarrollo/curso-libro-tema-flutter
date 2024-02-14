import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:themes/drawer/drawer.dart';
import 'package:themes/theme/theme.dart';

void main() => runApp(ChangeNotifierProvider(
      // create: (_) => new LayoutModel(),
      create: (_) => ThemeSwitch(true),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeSwitch>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Theme App',
      home: const ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeSwitch>(context).currentTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme App', style: appTheme.textTheme.displayLarge),
        backgroundColor: appTheme.primaryColor,
      ),
      body: Column(
        children: [
          const Text("Text example content"),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Card Content"),
            ),
          ),
          _Card(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Card Custom Content",
                style: appTheme.textTheme.displayMedium,
              ),
            ),
          )
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget content;

  const _Card({required this.content});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeSwitch>(context).currentTheme;

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: appTheme.primaryColor,
                blurRadius: 7,
                offset: const Offset(0, 0))
          ]),
      child: content,
    );
  }
}

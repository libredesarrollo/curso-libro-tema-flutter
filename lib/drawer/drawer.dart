import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themes/theme/theme.dart';

final _items = <Items>[
  Items(Icons.abc_outlined, 'ABC'),
  Items(Icons.access_alarm, 'Alarm'),
  Items(Icons.accessible_forward_outlined, 'Chair'),
  Items(Icons.account_balance_wallet_rounded, 'Wallet'),
  Items(Icons.workspaces_rounded, 'Workspaces'),
];

class Items {
  final IconData icon;
  final String title;

  Items(this.icon, this.title);
}

class _Items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, i) => const Divider(
          color: Colors.purple,
        ),
        itemCount: _items.length,
        itemBuilder: (context, i) => ListTile(
          leading: Icon(_items[i].icon, color: Colors.purple),
          title: Text(_items[i].title),
          trailing: Icon(_items[i].icon, color: Colors.purple),
          onTap: () {},
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeSwitch>(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              width: double.infinity,
              height: 200,
              color: appTheme.currentTheme.primaryColor,
              child: const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white24,
                  child: Text(
                    'ACY',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: _Items()),
          // Switch claro / oscuro (binario)
          ListTile(
            leading: const Icon(Icons.circle, color: Colors.purple),
            title: const Text('Dark Mode'),
            trailing: Switch.adaptive(
                value: appTheme.darkTheme,
                activeColor: Colors.purple,
                onChanged: (value) {
                  appTheme.darkTheme = value;
                }),
          ),
          // Selector de 3 temas con SegmentedButton (Material 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: Icon(Icons.light_mode),
                  label: Text('Claro'),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: Icon(Icons.dark_mode),
                  label: Text('Oscuro'),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: Icon(Icons.palette),
                  label: Text('Purple'),
                ),
              ],
              selected: {appTheme.themeMode},
              onSelectionChanged: (Set<ThemeMode> selection) {
                appTheme.themeMode = selection.first;
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

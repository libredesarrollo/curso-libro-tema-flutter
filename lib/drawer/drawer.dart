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
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> pageRoutes[i].page ));
          },
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
      child: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                width: double.infinity,
                height: 200,
                child: const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    'ACY',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(child: _Items()),
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
          ],
        ),
      ),
    );
  }
}

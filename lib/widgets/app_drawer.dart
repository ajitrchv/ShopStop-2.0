



import 'package:flutter/material.dart';

import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_route.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text("Hello Friend"),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
            leading: const Icon(
              Icons.shop,
            ),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
        const Divider(),
        ListTile(
            leading: const Icon(
              Icons.my_library_books_outlined,
            ),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            }),
        const Divider(),
        ListTile(
            leading: const Icon(
              Icons.store_mall_directory_rounded,
            ),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(builder: (ctx) => OrderScreen(),),);


            }),
            const Divider(),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            }),
            const Divider(),

      ]),
    );
  }
}

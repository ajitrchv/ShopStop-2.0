import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/auth_screen.dart';
import '../providers/orders.dart';
import '../providers/cart.dart';

import '../screens/products_overview.dart';
import '../screens/product_detail_screen.dart';
import '../providers/products.dart';
import '../screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import '../screens/edit_product.dart';
import '../providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //==========providers==============
        ChangeNotifierProvider(
          create: (ctx) => Products()
        ),

        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),

        ChangeNotifierProvider(
          create:  (ctx) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'ShopStop',
        theme: ThemeData(
          primarySwatch: Colors.green,
          // ignore: deprecated_member_use
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
        ),
        home: AuthScreen(),
        routes: {
          ProductDetail.routeName: (ctx) => ProductDetail(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProduct.routeName: (ctx) => EditProduct(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override 
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text('ShopStop'),),
//     body: Center(child: Text('Hi From App'),),);
//   }
// }
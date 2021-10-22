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
            create: (ctx) => Auth(),
          ),

          ChangeNotifierProxyProvider<Auth, Products>(
            
             create: (ctx) => Products('', [], ''), 


            update:  (ctx, auth, previousProducts) => 
            Products(auth.token,
            previousProducts == null ?
             [] : previousProducts.items, auth.userId),

            
            ),

          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),

          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders('','',[]),
            update: (ctx, auth, previousOrders) => 
            Orders(auth.token,auth.userId, previousOrders == null ?
            [] : previousOrders.orders,),
          ),


        ],


//======================================================================================

        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'ShopStop',
            theme: ThemeData(
              primarySwatch: Colors.green,
              // ignore: deprecated_member_use
              accentColor: Colors.deepOrangeAccent,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth ? ProductsOverview() : AuthScreen(),
            routes: {
              ProductDetail.routeName: (ctx) => ProductDetail(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProduct.routeName: (ctx) => EditProduct(),
              AuthScreen.routeName: (ctx) => AuthScreen(),
              ProductsOverview.routeName: (ctx) => ProductsOverview(),
            },
          ),
        ));
  }
}

// class MyHomePage extends StatelessWidget {
//   @override 
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text('ShopStop'),),
//     body: Center(child: Text('Hi From App'),),);
//   }
// }
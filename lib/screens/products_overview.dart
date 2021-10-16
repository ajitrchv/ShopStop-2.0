

import 'package:flutter/material.dart';
import 'package:shopstop/screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';



enum filterOptions{
  favorites,
  all,
}

// ignore: use_key_in_widget_constructors
class ProductsOverview extends StatefulWidget {
  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {

  var _showFavorites = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopStop'),
        actions: [

          PopupMenuButton(

          onSelected: (filterOptions selectedValue) {

            setState(() {
            if(selectedValue == filterOptions.favorites) {
              _showFavorites = true;
            }
           else {
              _showFavorites = false;
            }              
            });
            },  
          icon:const Icon(Icons.more_vert_rounded),
          itemBuilder: (_) => [
            const PopupMenuItem(child: Text('Favorites'), value: filterOptions.favorites),
            const PopupMenuItem(child: Text('All'), value: filterOptions.all)
          ]
          ,),
          Consumer<Cart>(
          builder: (_, cartData,ch) => Badge(
          child: ch!,  
          value: cartData.itemCount.toString(),),
          child: IconButton(icon: const Icon(Icons.shopping_cart_sharp), 
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },),),
        ]
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavorites),
    );
  }
}


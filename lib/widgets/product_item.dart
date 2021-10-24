

import 'package:flutter/material.dart';
import 'package:shopstop/providers/cart.dart';
import '../providers/products.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class productItem extends StatelessWidget {
  //const productItem({ Key? key }) : super(key: key);
  // final String id;
  // final String title;
  // final String imageUrl;
  // final double price;
  // productItem(this.id, this.title, this.imageUrl, this.price);

  @override
  Widget build(BuildContext context) {

    final scaf = Scaffold.of(context);
    //++++++++++++++++++++providers=======================

    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    //==================================================
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Card(
          elevation: 5,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetail.routeName, arguments: product.id);
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(placeholder: const AssetImage('assets/images/ph.png'), 
              image: NetworkImage(product.imageUrl),
              fit:BoxFit.cover,
              ),
            ),
            ),
        ),
        header: Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            '₹.${product.price}',
            style: const TextStyle(backgroundColor: Colors.white60),
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,

//===================  using consumer =======================S===
          
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: (product.isFavorite
                  ? const Icon(Icons.favorite_rounded)
                  : const Icon(Icons.favorite_outline_sharp)),
              onPressed: () async{
              try{  
               product.toggleFavoriteStatus( authData.token, authData.userId
               );
               product.isFavorite?{
              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to favorites')))
               }
              :   {
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed from favorites')))
                };
              }
              catch(error){
                  scaf.showSnackBar(const SnackBar(content: Text('Not able to add to favorites!')));
              }
              },
              // ignore: deprecated_member_use
              color: Theme.of(context).accentColor,
            ),
          ),

//===============================================================

          trailing: IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  content: const Text(
                    'Added item to the Cart!',
                    textAlign: TextAlign.left,
                  ),
                  dismissDirection: DismissDirection.up,
                  duration: const Duration(seconds: 3),
                  action:
                      SnackBarAction(label: ('Undo'), onPressed: () {
                        cart.removeSingleItem(product.id);
                      },),
                ),
              );
            },

//=================================================================
            // ignore: deprecated_member_use
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopstop/screens/edit_product.dart';

import '../widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';



class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_products';

  Future<void> _refreshProd(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  //final prodx = 'nulldata';
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProduct.routeName, arguments: false
                );
              },),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProd(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: (_, i) => UserProductItem(productData.items[i].title,
                  productData.items[i].imageUrl, productData.items[i].id)),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = '/user_products';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [IconButton(onPressed: () {
         
        }, icon: const Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (_, i) => UserProductItem(
                productData.items[i].title, productData.items[i].imageUrl)),
      ),
    );
  }
}

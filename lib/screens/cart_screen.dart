import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shopstop/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart' as ci;
import '../providers/products.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: (AppBar(
        title: const Text("Cart"),
      )),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Chip(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        label: Text(
                          '₹ ${cart.totalAmount}',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    child: Text(
                      'Checkout',
                      style: (TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), 
                          cart.totalAmount);
                          cart.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, indx) => ci.CartItem(
                cart.items.values.toList()[indx].id,
                cart.items.keys.toList()[indx],
                cart.items.values.toList()[indx].price,
                cart.items.values.toList()[indx].quantity,
                cart.items.values.toList()[indx].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

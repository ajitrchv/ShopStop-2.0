import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shopstop/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart' as ci;
import '../providers/products.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isloading = false;
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

//======================================================================================================

                  
                  TextButton(
                    child: 
                    _isloading? 
                    const CircularProgressIndicator(strokeWidth: 10,)
                    :
                    Text(
                      'Checkout',
                      style: (
                      (cart.totalAmount <=0 || _isloading == true)
                      ? 
                      TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 18)
                           :
                      TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                    ),
                    onPressed: (cart.totalAmount <=0 || _isloading == true)? null : 
                    () async {
                      setState(() {
                        _isloading =true;
                      });
                      await Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), 
                          cart.totalAmount);
                          setState(() {
                            _isloading =false;
                          });
                          cart.clear();
                    },
                    
                  ),

//======================================================================================================


                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
          (cart.totalAmount <=0)?
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
            const Center(child: Text('Uh, oh! Cart Empty!', style: TextStyle(color: Colors.red, fontSize: 15),),),
            const SizedBox(height: 10),
            Center(child: ElevatedButton(onPressed: Navigator.of(context).pop, child: const Text('Go back to Products',style: TextStyle(color: Colors.white, fontSize: 15) )),),
              //const Center(child: Text('and add some products', style: TextStyle(color: Colors.green,fontSize: 15),),),
            ],),
          )
         
          
          :
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

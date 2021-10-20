

import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  //const OrderScreen({Key? key}) : super(key: key);
   static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;

  @override
  void initState(){
    Future.delayed(Duration.zero).then((_) {
    setState(() {
      _isLoading = true;
    });
     Provider.of<Orders>(context, listen: false).fetchAndSetOrders().
     then((_) {
       setState(() {
      _isLoading = false;
    });});
    });
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Orders:"),
        ),
        drawer: AppDrawer(),
         body: _isLoading ? 
        const Center(child:CircularProgressIndicator(strokeWidth: 10,)) 
        :
         ListView.builder(
            itemCount: orderData.orders.length, 
            itemBuilder: (ctx,indx) => OrderItem(orderData.orders[indx])),);
  }
}

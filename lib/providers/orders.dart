import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shopstop/providers/auth.dart';
import 'package:shopstop/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  final String? userId;
  Orders(this.authToken, this.userId, this._orders, );
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try{
    final Uri url =
        Uri.parse(
        'https://shopstop-a9a9a-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    
    // print('==================================================');
    // print(extractedData);
    // print('==================================================');
    //print(DateTime.parse(extractedData['products']['dateTime']));
    
    if(extractedData == null){
      return;
    }
    extractedData.forEach((orderId, orderData) {
    // print(DateTime.parse(orderData['dateTime']));
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: (DateTime.parse(orderData['datetime'])),
          products: (orderData['products'] as List<dynamic>)
              .map((e) => CartItem(
                    id: e['id'],
                    price: e['price'],
                    quantity: e['quantity'],
                    title: e['title'],
                  ))
              .toList(),
        ),
      );
    });
    _orders =  loadedOrders.reversed.toList();
    notifyListeners();
}catch(error){
    print(error);
    rethrow;
  }
  }


  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try{
    final Uri url =
        Uri.parse(
        'https://shopstop-a9a9a-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'datetime': timestamp.toIso8601String(),//toString()
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'title': cp.title,
                  })
              .toList(),
        }));

    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timestamp,
            products: cartProducts));

    notifyListeners();
  }catch(error){
    print(error);
    rethrow;
  }
}
}

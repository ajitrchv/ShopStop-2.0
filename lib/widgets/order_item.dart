import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart' show DateFormat;
import 'dart:math';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  // ignore: use_key_in_widget_constructors
  const OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text("₹ ${widget.order.amount}"),
              subtitle: Text(DateFormat('dd/MM/yyyy | hh:mm')
                  .format(widget.order.dateTime)),
              trailing: IconButton(
                icon: _expanded
                    ? (const Icon(Icons.expand_less))
                    : (const Icon(Icons.expand_more)),
                onPressed: () => {
                  setState(() {
                    _expanded = !_expanded;
                  })
                },
              ),
            ),
            if (_expanded)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: min(widget.order.products.length * 20 + 50, 100),
                child: ListView(
                    children: widget.order.products
                        .map((prod) => Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  prod.title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                Text('${prod.quantity} X ₹ ${prod.price}',style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: (Colors.blueGrey)),)
                              ],
                            ))
                        .toList()),
              )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/src/response.dart';

import '../providers/products.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  bool isFavorite;

  void toggleFavoriteStatus(id) async{
    isFavorite = !isFavorite;
    notifyListeners();
    
    final url = Uri.https('shopstop-a9a9a-default-rtdb.firebaseio.com', '/products/$id.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final favtog = extractedData['isFavorite'];
    await http.patch(url, body: json.encode({
        'isFavorite': !favtog
    }));
    print('Data of extracted data$extractedData');
  }

  Product({
  required this.id, 
  required this.title, 
  required this.description, 
  required this.price, 
  required this.imageUrl,
  this.isFavorite = false}
  );
}

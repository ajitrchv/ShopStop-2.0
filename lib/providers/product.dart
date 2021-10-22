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
  //final String token;
  //final String creatorId;
  bool isFavorite;

  Future<void> toggleFavoriteStatus(String? token, String? userId) async{
    
    
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://shopstop-a9a9a-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token');
    try{
    // final response = await http.get(url);
    // final extractedData = json.decode(response.body) as Map<String, dynamic>;
    // final favtog = extractedData['isFavorite'];
    final response = await http.put(url, body: json.encode(
        isFavorite,
    ));
    if(response.statusCode>=400){
       isFavorite = oldStatus;
    }
    //print('Data of extracted data$extractedData');
    }
    catch (error){
      isFavorite =oldStatus;
    }
    
    notifyListeners();
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

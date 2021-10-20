import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  //   Product(
  //     id: 'p1',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Trousers',
  //     description: 'A nice pair of trousers.',
  //     price: 59.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Yellow Scarf',
  //     description: 'Warm and cozy - exactly what you need for the winter.',
  //     price: 19.99,
  //     imageUrl:
  //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'A Pan',
  //     description: 'Prepare any meal you want.',
  //     price: 49.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   ),
  // ];

  var _showFavoritesOnly = false;

  List<Product> get items {
    // if(_showFavoritesOnly){
    // return _items.where((item) =>
    // (item.isFavorite)).toList();
    // }
    // else {}
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  // void showFavorites(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }


  //=============================================================================

  Future<void> fetchAndSetProducts() async {
    try {
    final Uri url = Uri.parse(
        'https://shopstop-a9a9a-default-rtdb.firebaseio.com/products.json');
    
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProd = [];
      extractedData.forEach((prodId, prodData) {
        // print(prodId);
        // print(prodData['description'],);
        // print(prodData['price']);
        // print(prodData['imageUrl']);
        loadedProd.insert(0,Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: prodData['isFavorite']
        ));
      });
      _items = loadedProd;
      //print(loadedProd);
      notifyListeners();
    } catch (error) {
      print(error);
     rethrow;
    }
  }

  Future<void> addProducts(Product product, String id) async {
//============================== Server DB Management ==================================================================
    var response;
    var newProduct1;
    if(id != ''){
    try {final Uri url =
        Uri.parse(
        'https://shopstop-a9a9a-default-rtdb.firebaseio.com/products.json');
    
      final response1 = //adds the following code to response, await makes it return a future to save
          await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
          // 'id':
        }),
      );
      response = response1;
      var xid = json.decode(response.body);
        newProduct1 = Product(
        title: product.title,
        description: product.description,
        id: xid['name'],
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      );
      deleteProduct(id);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
    }
    //========================================================================
    else{
    try {
    final Uri url =
        Uri.parse(
        'https://shopstop-a9a9a-default-rtdb.firebaseio.com/products.json');
    
      final response1 = //adds the following code to response, await makes it return a future to save
          await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
          // 'id':
        }),
      );
      response = response1;
      var xid = json.decode(response.body);
        newProduct1 = Product(
        title: product.title,
        description: product.description,
        id: xid['name'],
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      );
      deleteProduct(id);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
    }

      // _items.removeWhere((prod) => prod.id == id);
      // //_items.add(newProduct1);
      // _items.insert(0, newProduct1);
  }

//======================================================================================================================

  void updateProducts(String id, Product newProduct) {
    //_items.add(newProduct);
    _items.removeWhere((prod) => prod.id == id);
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  // void deleteProduct(String id) {
  //  
  //   notifyListeners();
  // }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://shopstop-a9a9a-default-rtdb.firebaseio.com/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
     _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw const HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}


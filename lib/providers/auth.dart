import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';


class Auth with ChangeNotifier {

  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth{
    return token != null;
  }

  // String? get token {
  //   if(_expiryDate != null  
  //   && 
  //   _expiryDate!.isAfter(DateTime.now()) 
  //   && _token != '') {
  //     return _token;
  //   }
  //   return null;
  // }

      String? get token {
        if (_expiryDate != null &&
            _expiryDate!.isAfter(DateTime.now()) &&
            _token != null) {
          return _token;
        }
        return null;
      }

  String? get userId{
    return _userId;
  }

  Future<void> _authenticate(String? email, String? password, String? urlSegment) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCT1w_P0k5YmqySijQw-CrLsTb2nXcvkYA');
    try{
    final response =  await http.post(url, body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }));
    final responseData = json.decode(response.body);
    if(responseData['error'] != null){
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().
    add(Duration(
      seconds: int.parse(responseData['expiresIn'])),);
      notifyListeners();
    }
    catch(error){
      print('Hii Im   Error');
      rethrow;}
    // print(json.decode(response.body));
  }

  Future<void> signup(String? email, String? password) async{
  
    var urlSeg = 'signUp';
    return _authenticate(email, password, urlSeg);

  }

  Future<void> login(String? email, String? password) async{
    
    var urlSeg = 'signInWithPassword';
    return _authenticate(email, password, urlSeg);

  }

}
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:async';


class Auth with ChangeNotifier {

  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

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
      _autologout();
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

  void logout(){
    _token = null;
    _userId = null;
    _expiryDate = null;

    if(_authTimer != null){
      _authTimer!.cancel();
      _authTimer = null;
    }

    notifyListeners();
  }

  void _autologout()
  {
    if(_authTimer != null){
      _authTimer!.cancel();
    }
     final _timexp =  _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: _timexp), logout);
  }

}
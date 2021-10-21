import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {

  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> _authenticate(String? email, String? password, String? urlSegment) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCT1w_P0k5YmqySijQw-CrLsTb2nXcvkYA');
    final response =  await http.post(url, body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }));
    print(json.decode(response.body));
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
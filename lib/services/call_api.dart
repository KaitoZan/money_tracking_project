// ignore_for_file: prefer_interpolation_to_compose_strings
//call_api.dart
//This file will contain various methods used to call different APIs according to the functional purposes of the App.\

import 'dart:convert';

import 'package:money_tracking_project/models/money.dart';
import 'package:money_tracking_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:money_tracking_project/utils/env.dart';

class CallAPI {
  static Future<User> callcheckPassAPI(User user) async {
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/moneytrackingAPI/apis/checkPassAPI.php'), // api url
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (responseData.statusCode == 200) {
      return User.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }
  static Future<User> callregisterAPI(User user) async {
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/moneytrackingAPI/apis/registerAPI.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (responseData.statusCode == 200) {
      return User.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }
static Future<List<Money>> callgetAllMoneyByuserId(Money trip) async {
  final responseData = await http.post(
    Uri.parse(Env.hostName + '/moneytrackingAPI/apis/getAllMoneyByuserId.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(trip.toJson()),
  );

  if (responseData.statusCode == 200) {
    print('Response data: ${responseData.body}');
    
    final response = jsonDecode(responseData.body);
    if (response is List) {
      return response.map<Money>((json) => Money.fromJson(json)).toList();
    } else if (response is Map) {
      if (response.containsKey('data')) {
        final data = response['data'];
        if (data is List) {
          return data.map<Money>((json) => Money.fromJson(json)).toList();
        } else {
          print('Expected "data" to be a List, but got ${data.runtimeType}');
          return [];
        }
      } else {
        print('No key "data" found in the response');
        return [];
      }
    } else {
      print('Unexpected response type: ${response.runtimeType}');
      return [];
    }
  } else {
    throw Exception('Failed to call API');
  }
}
  static Future<Money> callinsertInOutComeAPI(Money trip) async {
    final responseData = await http.post(
      Uri.parse(Env.hostName + '/moneytrackingAPI/apis/insertInOutComeAPI.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(trip.toJson()),
    );
    if (responseData.statusCode == 200) {
      return Money.fromJson(jsonDecode(responseData.body));
    } else {
      throw Exception('Failed to call API');
    }
  }

}
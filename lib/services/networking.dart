import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Network {
  final String URL;
  Network(this.URL);

  Future getLocation() async{
    http.Response response = await http.get(URL);
    var data = response.body;
    if(response.statusCode ==200){
      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }

  }
}
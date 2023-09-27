import 'dart:convert';

import 'package:assignment/model.dart';
import 'package:http/http.dart' as http;

class ImageRepositry{


  Future<ImageModel> fetchImagesApi (String imagetype) async{
    final response = await http.get(Uri.parse('https://pixabay.com/api/?key=39662736-324ac4c7d13fb73089ed0077b&str=$imagetype&image_type=photo&pretty=true'));
    if(response.statusCode == 200){
      var body = jsonDecode(response.body.toString());
      return ImageModel.fromJson(body);
    }
    throw Exception('some error');
  }


}
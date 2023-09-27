

import 'package:assignment/model.dart';
import 'package:assignment/repository/image_repositry.dart';

class ImageViewModel{
final _rep = ImageRepositry();
  Future<ImageModel> fetchImagesApi (String imageType) async{
    final response = await _rep.fetchImagesApi(imageType);
    return response;
  }


}
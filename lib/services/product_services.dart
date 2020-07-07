import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductServices {
  Future<dynamic> productAddition(
    String productCategory,
    String productName,
    int productPrice,
    int productQuantity,
    int quantityAlert,
    String barcode,
    String productDescription,
    String image,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    String token = sharedPreferences.getString('token');
    final String url =
        'https://stockfare-io.herokuapp.com/api/v1/inventory/create-category/$branchId/';
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "name": productCategory,
          "product": {
            "product_unit": {
              "price": productPrice,
              "quantity": productQuantity,
              "limit": quantityAlert,
            },
            "images": image,
            "name": productName,
            "barcode": barcode,
            "description": productDescription,
          }
        }));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      sharedPreferences.setString("token", responseJson['token']['access']);
      print(responseJson);
    } else {
      print(response.body);
      return null;
    }
  }

  Future<dynamic> productAdd(String text, File file) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String branchId = sharedPreferences.getString('branchId');
    final String url =
        'http://stockfare-io.herokuapp.com/api/v2/users/register/$branchId';
    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields["name"] = text;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file_field", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }
}

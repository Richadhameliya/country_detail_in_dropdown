import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dropdown_model.dart';

class ProductApi {
  static var client = http.Client();

  static Future<CountryApiModel> fetchCountryData() async {
    final response = await client
        .get(Uri.parse('https://mascotas.maskotapp.org/api/countries'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return countryApiFromJson(jsonString);
    } else {
      throw Exception('Failed to load country data');
    }
  }
}

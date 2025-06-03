import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/cfa1ca14-b058-4b1b-9589-af167ed16f37'));
    final data = jsonDecode(response.body);

    return data;
  }
}

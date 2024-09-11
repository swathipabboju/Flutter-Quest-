import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_app/model/get_department_response.dart';

class ApiService {
  final String baseUrl = "https://19cghmc.cgg.gov.in/myghmcwebapi/";

  Future<List<GetDepartmentResponse>> getDepDetails() async {
    final response =
        await http.get(Uri.parse('$baseUrl/Grievance/getDepartmentCatType'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((post) => GetDepartmentResponse.fromJson(post))
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

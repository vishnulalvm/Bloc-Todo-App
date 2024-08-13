// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/domine/model.dart';

class HomeRepository {
  Future<List<TodoModel>> fetchApi() async {
    try {
      const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        List json = jsonDecode(response.body)['items'];
        List<TodoModel> list = json.map((e) => TodoModel.fromJson(e)).toList();
        return list;
      }
    } catch (e) {
      // print("exceptions occured in fetching data");
      throw Exception(e);
    }
    throw Exception("failed to fetch data");
  }

  Future<void> postApi(String title, String description) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print("post success hiiiiiiii");
        // print(response.body);
      } else {
        print("post failed");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> deleteApi(String id) async {
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);

    try {
      final response =
          await http.delete(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        print("data delete successfully");
      } else {
        print("data deletion failed");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> updateApi(String id, String title, String description) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);

    try {
      final response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("data updated successfully");
      } else {
        print("data updation failed");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}

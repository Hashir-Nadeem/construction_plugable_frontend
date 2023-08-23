import 'dart:convert';
import 'package:http/http.dart';
import 'package:loginform/Global.dart';
import 'package:loginform/Models/jobs.dart';
import 'package:loginform/Models/policy.dart';
import 'Models/employee.dart';

class remoteService {
  static Future<employee?> login(String email, String password) async {
    final url = Uri.parse(
        globalData.url + '/home/login?email=$email&password=$password');
    Response response = await get(url);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var emp = employee.fromJson(body);
      return emp;
    }
    return null;
  }

  static Future<String> signUp(
      String firstName, String lastName, String email, String password) async {
    final url = Uri.parse(globalData.url +
        '/home/signup?firstName=$firstName&lastName=$lastName&email=$email&password=$password');
    Response response = await post(url);

    if (response.body != "") {
      return response.body;
    }
    return "";
  }

  static Future<int> checkIn(String jobLatitude, String jobLongitude,
      String latitude, String longitude, String radius) async {
    var uri = globalData.url +
        '/home/checkin?jobLatitude=$jobLatitude&jobLongitude=$jobLongitude&latitude=$latitude&longitude=$longitude&radius=$radius';
    final url = Uri.parse(uri);
    Response response = await post(url);

    if (response.statusCode == 200) {
      return 200;
    }
    return 404;
  }

  static Future<int> verification(String id, String code) async {
    final url = Uri.parse(globalData.url + '/home/code?Id=$id&code=$code');
    Response response = await post(url);

    if (response.statusCode == 200) {
      return 200;
    }
    return 400;
  }

  static Future<int> resentCode(String id) async {
    final url = Uri.parse(globalData.url + 'home/Recode?Id=$id');
    Response response = await post(url);

    if (response.statusCode == 200) {
      return 200;
    }
    return 400;
  }

  static Future<Policy?> policy() async {
    final url = Uri.parse(globalData.url + '/home/policy');
    Response response = await get(url);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var emp = Policy.fromJson(body);
      return emp;
    }
    return null;
  }

  static Future<List<EmpJobs>?> jobs(String id) async {
    final url = Uri.parse(globalData.url + '/home/jobs?id=$id');
    Response response = await get(url);

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => EmpJobs.fromJson(e)).toList();
    }
    return null;
  }

  static Future<bool> validConfig(
      String email, String uri, String password) async {
    final url = Uri.parse(
        uri + '/home/config?email=$email&url=$uri&password=$password');
    Response response = await get(url);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}

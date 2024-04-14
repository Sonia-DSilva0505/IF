import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthController {
  Future<String> login(
    String username,
    String password,
  ) async {
    Uri uri = Uri.parse('https://acm-if-backend.onrender.com/api/acm-if/login');
    final res = await http.post(uri,
        body: jsonEncode({
          "email": username.toString(),
          "password": password.toString(),
        }),
        headers: {'Content-Type': 'application/json'});
    final body = res.body;
    if (res.statusCode != 200) {
      return "Incorrect User Details";
    }

    final response = jsonDecode(body);
    init(response);
    return "Success";
  }

  Future<String> register(
    String name,
    String sap,
    String gender,
    String email,
    String whatsapp,
    String dept,
    String academicYear,
    String graduationYear,
    String password,
    String confirmPassword,
    File pdf,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://acm-if-backend.onrender.com/api/acm-if/register"),
    );
    request.fields.addAll({
      "name": name,
      "email": email,
      "sap": sap,
      "contact": whatsapp,
      "gender": gender,
      "academicYear": academicYear,
      "department": dept,
      "graduationYear": graduationYear,
      'password': password,
      "confirmPassword": confirmPassword,
    });
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'resume',
      pdf.path,
      contentType: MediaType("application", "pdf"),
    );
    request.files.add(
      multipartFile,
    );
    var res = await request.send();
    var responseBody = await res.stream.bytesToString();
    var response = jsonDecode(responseBody);

    if (res.statusCode == 200) {
      init(response);
      return "Success";
    } else {
      return response["message"];
    }
  }

  Future<List<String>> updateResume(
    String userid,
    File pdf,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://acm-if-backend.onrender.com/api/acm-if/update-resume/$userid"),
    );
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'resume',
      pdf.path,
      contentType: MediaType("application", "pdf"),
    );
    request.files.add(
      multipartFile,
    );
    var res = await request.send();
    var responseBody = await res.stream.bytesToString();
    var response = jsonDecode(responseBody);
    if (res.statusCode == 200) {
      return ["Success", response["new"]["resume"]];
    } else {
      return [response["message"]];
    }
  }

  void init(res) async {
    try {
      final box = GetStorage();
      String dept = res["data"]["department"];
      switch (dept) {
        case "Computer Engineering":
          dept = "CE";
          break;
        case "Information Technology":
          dept = "IT";
          break;
        case "Computer Science and Engineering (IOT, Cybersecurity and Blockchain)":
          dept = "ICB";
          break;
        case "Electronics and Telecommunication Engineering":
          dept = "EXTC";
          break;
        case "Artificial Intelligence and Data Science":
          dept = "AI/DS";
          break;
        case "Artificial Intelligence and Machine Learning":
          dept = "AI/ML";
          break;
        case "Computer Science and Engineering (Data Science)":
          dept = "CSE DS";
          break;
        case "Mechanical Engineering":
          dept = "MECH";
          break;
        default:
          dept = dept;
      }
      box.write('token', res['token']);
      box.write('id', res['data']['_id']);
      box.write('name', res['data']['name']);
      box.write('email', res['data']['email']);
      box.write('sapid', res['data']['sap']);
      box.write('contact', res['data']['contact']);
      box.write('department', dept);
      box.write('resume', res['data']['resume']);
    } catch (e) {
      log(e.toString());
    }
  }
}

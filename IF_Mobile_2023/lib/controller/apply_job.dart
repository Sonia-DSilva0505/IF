import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<String> addCart(
  String jobid,
) async {
  String userid = GetStorage().read("id");
  Uri uri =
      Uri.parse("https://acm-if-backend.onrender.com/api/acm-if/apply-job");
  final res = await http.post(uri,
      body: jsonEncode({
        "userId": userid,
        "jobId": jobid,
      }),
      headers: {'Content-Type': 'application/json'});
  final response = jsonDecode(res.body);
  if (response["message"] == 'Job Successfully Applied.') {
    return 'Successfully applied for Job.';
  } else if (response["message"] == 'Job Already applied.') {
    return 'Already applied for Job';
  }
  return "Error";
}

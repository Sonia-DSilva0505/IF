import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internship_fair/model/get_job_model.dart';

class GetJobApi {
  List<Data>? _getJob = [];

  getJobData(int low, int high, String mode) async {
    Map<String, Object> body;
    String url = "https://acm-if-backend.onrender.com/api/acm-if/getJobsByFilter";
    if (mode == "") {
      body ={"lowStipend": low, "highStipend": high};
    } else {
      body = {"lowStipend": low, "highStipend": high, "mode": mode};
    }
    final res = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final response = jsonDecode(res.body);

    if (res.statusCode == 200) {
      var getJob = GetJob.fromJson(response);
      _getJob = getJob.data;
      return _getJob;
    }
  }
}

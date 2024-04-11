import 'dart:convert';
import 'package:internship_fair/model/get_job_model.dart';
import 'package:http/http.dart' as http;

class AppliedJobApi {
  List<Data> _getJob = [];

  Future<List<Data>?> getAppliedJobs(String userId) async {
    final url = Uri.parse(
        'https://acm-if-backend.onrender.com/api/acm-if/applied-jobs/$userId');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data["messsage"] != "No Jobs applied") {
        final getJob = GetJob.fromJson(data);
        _getJob = getJob.data ?? [];
      }
    }
    return _getJob;
  }
}

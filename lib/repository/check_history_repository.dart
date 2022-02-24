import 'dart:convert';

import 'package:app_puninar_test/model/model.dart';
import 'package:http/http.dart' as http;

class CheckHistoryRepository {
  final String url;
  CheckHistoryRepository({
    required this.url,
  });

  var headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  Future<List<CheckHistoryModel>> findCheckHistory(DateTime datetime) async {
    var response = await http.post(Uri.parse(url + '/history'),
        headers: headers, body: json.encode({"datetime": datetime.toString()}));
    List data = json.decode(response.body);
    return data.map((item) => CheckHistoryModel.fromMap(item)).toList();
  }
}

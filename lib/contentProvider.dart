import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './dataModel.dart';
import 'dart:convert';

class ContentProvider with ChangeNotifier {
  DataModel dataModel;
  Future<void> getData() async {
    final url = 'https://kawalcovid19.harippe.id/api/summary';
    final response = await http.get(url);

    final result = json.decode(response.body) as Map<String, dynamic>;

    print(result.toString());

    dataModel = DataModel(
      konfirmasi: result['confirmed']['value'],
      sembuh: result['recovered']['value'],
      meninggal: result['deaths']['value'],
      perawatan: result['activeCare']['value'],
      waktuUpadte: result['metadata']['lastUpdatedAt'],
    );
    // print(dataModel);

    notifyListeners();
  }
}

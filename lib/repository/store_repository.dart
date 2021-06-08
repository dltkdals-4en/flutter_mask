import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoreRepository {
  Future<List<Store>> fetch(double lat, double lng) async {
    final List<Store> stores = [];

    var url = Uri.parse(
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json?lat=$lat&lng=$lng&m=1000');
    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));

    final jsonStores = jsonResult['stores'];
    // setState(() {

    jsonStores.forEach((e) {
      final store = Store.fromJson(e);
      stores.add(store);
    });

    print('fetch!!');
    return stores.where((e) {
      return e.remainStat == 'plenty' ||
          e.remainStat == 'some' ||
          e.remainStat == 'few';
    }).toList();
  }
}

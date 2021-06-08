import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:url_launcher/url_launcher.dart';


class RemainStatListTile extends StatelessWidget {
  final Store store;


  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Text(store.addr),
      trailing: _buildRemainStatWidget(store),
      onTap: () {
        _launchURL(store.lat,store.lng);
      },
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    var remaintStat = '판매중지';
    var description = '재고량 없음';
    var color = Colors.black;
    switch (store.remainStat) {
      case 'plenty':
        remaintStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remaintStat = '보통';
        description = '30개 ~100개 ';
        color = Colors.yellow;
        break;
      case 'few':
        remaintStat = '부족';
        description = '2개 ~30개';
        color = Colors.red;
        break;
      case 'empty':
        remaintStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          remaintStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(description, style: TextStyle(color: color)),
      ],
    );
  }

 _launchURL(double lat, double lng) async {
   final _url = 'https://google.com/maps/search/?api=1&query=$lat,$lng';
   if( await canLaunch(_url)){
         await launch(_url);
   }else{
         throw 'Could not launch $_url';}
  }
}

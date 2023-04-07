import 'package:flutter_news/constants/Constants.dart';
import 'package:http/http.dart' as http;

// 使用网上公共接口
class NetWork {
  static bool _debug = true;
  //网易新闻的host
  static String NETEAST_HOST = "https://c.m.163.com/";

  static String getHost(int type) {
    switch (type) {
      case Constants.TYPE_NET_NETEASE_NEWS:
        return NETEAST_HOST;

      default:
        return '';
    }
  }

  /* 基础GET请求 */
  static Future<String> get(String url, {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    http.Response res = await http.get(url, headers: getCommonHeader());
    if (_debug) {
      print('发起Get请求_____$url|________________${res.body}|');
    }
    return res.body;
  }

/* 基础POST请求 */
  static Future<String> post(String url, {Map<String, String> params}) async {
    http.Response res =
        await http.post(url, body: params, headers: getCommonHeader());
    if (_debug) {
      print(
          '|发起Post请求|_______|$url|______|${params.toString()}|________|${res.body}|');
    }
    return res.body;
  }

  static Map<String, String> getCommonHeader() {
    Map<String, String> header = Map();
    header['User-Agent'] =
        'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36';
    return header;
  }
}

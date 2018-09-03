import 'dart:async';
import 'package:dio/dio.dart';
import 'package:idota/utils/AppStatus.dart';

class HttpUtils {
  static HttpUtils _instance;

//  static String BASE_URL = "http://74.82.210.245:8090";
  static String BASE_URL = "http://192.168.66.107:8088";
  static String IMG_URL = BASE_URL + "/media/";
  Options options;
  Dio dio;

  static HttpUtils getInstance() {
    if (_instance == null) {
      _instance = HttpUtils();
    }

    return _instance;
  }

  HttpUtils() {
    options = Options();
    options.baseUrl = BASE_URL;
    options.connectTimeout = 1500;
    options.receiveTimeout = 500;
    dio = Dio(options);
  }

  initHeader() async {
    var token = await AppStatus.getInstance().getToken();
    options.headers = {"Authorization": "Token $token"};
    dio = Dio(options);
  }

  Future<Map> get(path, {data}) async {
    Map res = Map();
    try {
      Response response = await dio.get(path, data: data);
      res = response.data;
    } on DioError catch (e) {
      res['code'] = 4;
      res['msg'] = "网络错误";
    } finally {
      return res;
    }
  }

  Future<Map> post(path, {data}) async {
    Map res = Map();
    try {
      var response = await dio.post(path, data: FormData.from(data));
      res = response.data;
    } on DioError catch (e) {
      res['code'] = 4;
      res['msg'] = "网络错误";
    } finally {
      return res;
    }
  }

  setHeader(header) {
    options.headers = header;
  }
}

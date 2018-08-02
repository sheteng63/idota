import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

class HttpUtils {
  static HttpUtils _instance;
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
    options.baseUrl = "http://192.168.66.23:8088";
    options.connectTimeout = 1500;
    options.receiveTimeout = 500;

    dio = Dio(options);
  }

  Future<String> get(path, {data}) async {
    Response response =  await dio.get(path, data: data);
    return response.data;
  }

  Future<Map> post(path,{data}) async{
    Response response =  await dio.post(path,data: FormData.from(data));
    return response.data;
  }

  setHeader(header){
    options.headers = header;
    dio = Dio(options);
  }
}

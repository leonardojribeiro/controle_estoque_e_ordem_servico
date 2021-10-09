import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:controle_de_estoque_e_os/modules/auth/auth_controller.dart';

class ApiService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://controle-api-dot-global-leo.rj.r.appspot.com/'));
  //final _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.109:3333/'));

  Future<dynamic> post({required String url, dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final _options = Options(headers: {
        'Authorization': await Modular.get<AuthController>().getToken(),
      });
      final resposta = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _options,
      );
      return resposta.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        if (e.response?.data != null) {
          //  throw ErrorDescription(e.response?.data['message'].toString() ?? '');
        }
      } else {
        debugPrint(e.message.toString());
      }
      throw ApiError(
        errors: e.response?.data['errors'] is List ? e.response?.data['errors'] : null,
        statusCode: e.response?.statusCode,
        isOffline: e.message == 'XMLHttpRequest error.',
      );
    } catch (erro) {
      debugPrint(erro.toString());
    }
  }

  Future<dynamic> put({required String url, dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final _options = Options(headers: {
        'Authorization': await Modular.get<AuthController>().getToken(),
      });
      final resposta = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _options,
      );
      return resposta.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        if (e.response?.data != null) {
          // throw ErrorDescription(e.response?.data['message'].toString() ?? '');
        }
      } else {
        debugPrint(e.message);
      }
      throw ApiError(
        errors: e.response?.data?.errors is List ? e.response?.data?.errors : null,
        statusCode: e.response?.statusCode,
        isOffline: e.message == 'XMLHttpRequest error.',
      );
    } catch (erro) {
      debugPrint(erro.toString());
    }
  }

  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final _options = Options(headers: {
        'Authorization': await Modular.get<AuthController>().getToken(),
      });
      final resposta = await _dio.delete(
        url,
        queryParameters: queryParameters,
        options: _options,
      );
      return resposta.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        if (e.response?.data != null) {
          // throw ErrorDescription(e.response?.data['message'].toString() ?? '');
        }
      } else {
        debugPrint(e.message);
      }
      throw ApiError(
        errors: e.response?.data?.errors is List ? e.response?.data?.errors : null,
        statusCode: e.response?.statusCode,
        isOffline: e.message == 'XMLHttpRequest error.',
      );
    } catch (erro) {
      debugPrint(erro.toString());
    }
  }

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParamters,
  }) async {
    try {
      final _options = Options(headers: {
        'Authorization': await Modular.get<AuthController>().getToken(),
      });
      final resposta = await _dio.get(
        url,
        queryParameters: queryParamters,
        options: _options,
      );
      return resposta.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        // throw ErrorDescription(e.response?.data['message'].toString() ?? '');
      } else {
        debugPrint(e.message);
      }
      print('object');
      throw ApiError(
        errors: e.response?.data?.errors is List ? e.response?.data?.errors : null,
        statusCode: e.response?.statusCode,
        isOffline: e.message == 'XMLHttpRequest error.',
      );
    } catch (erro) {
      debugPrint(erro.toString());
    }
  }
}

class ApiError {
  final List<String>? errors;
  final int? statusCode;
  final bool? isOffline;
  ApiError({
    this.errors,
    this.statusCode,
    this.isOffline,
  });

  @override
  String toString() => 'ApiError(errors: $errors, statusCode: $statusCode, isOffline: $isOffline)';
}

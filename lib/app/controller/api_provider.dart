import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:pet_sense/app/controller/storage_provider.dart';
import 'package:pet_sense/app/model/api_response_model.dart';
import 'package:pet_sense/core/constants.dart';

class ApiProvider {
  static final http.Client _client = http.Client();

  // Check internet connectivity
  static Future<bool> _hasNetworkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Get headers with auth token if available
  static Map<String, String> _getHeaders() {
    Map<String, String> headers = Map.from(ApiConstants.headers);
    final token = StorageProvider.getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Generic request method
  static Future<ApiResponseModel<T>> _request<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      // Check network connectivity
      if (!await _hasNetworkConnection()) {
        return ApiResponseModel.error(
          message: AppValues.networkError,
          statusCode: 0,
        );
      }

      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final headers = _getHeaders();

      http.Response response;

      switch (method.toUpperCase()) {
        case 'POST':
          response = await _client
              .post(
                url,
                headers: headers,
                body: body != null ? json.encode(body) : null,
              )
              .timeout(ApiConstants.timeout);
          break;
        case 'GET':
          response = await _client
              .get(url, headers: headers)
              .timeout(ApiConstants.timeout);
          break;
        case 'PUT':
          response = await _client
              .put(
                url,
                headers: headers,
                body: body != null ? json.encode(body) : null,
              )
              .timeout(ApiConstants.timeout);
          break;
        case 'DELETE':
          response = await _client
              .delete(url, headers: headers)
              .timeout(ApiConstants.timeout);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      return _handleResponse<T>(response, fromJson);
    } on TimeoutException {
      return ApiResponseModel.error(
        message: AppValues.timeoutError,
        statusCode: 0,
      );
    } on SocketException {
      return ApiResponseModel.error(
        message: AppValues.networkError,
        statusCode: 0,
      );
    } catch (e) {
      return ApiResponseModel.error(
        message: '${AppValues.unknownError}: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // Handle API response
  static ApiResponseModel<T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    try {
      final Map<String, dynamic> responseData = json.decode(response.body);

      switch (response.statusCode) {
        case AppValues.success:
          T? data;
          if (fromJson != null) {
            data = fromJson(responseData);
          }
          return ApiResponseModel.success(
            message: responseData['message'] ?? 'Success',
            data: data,
            statusCode: response.statusCode,
          );

        case AppValues.badRequest:
        case AppValues.unauthorized:
        case AppValues.notFound:
        case AppValues.conflict:
          return ApiResponseModel.error(
            message: responseData['error'] ?? 'Request failed',
            statusCode: response.statusCode,
          );

        case AppValues.serverError:
        default:
          return ApiResponseModel.error(
            message: responseData['error'] ?? AppValues.serverErrorMessage,
            statusCode: response.statusCode,
          );
      }
    } catch (e) {
      return ApiResponseModel.error(
        message: 'Failed to parse response: ${e.toString()}',
        statusCode: response.statusCode,
      );
    }
  }

  // POST request
  static Future<ApiResponseModel<T>> post<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    return _request<T>(
      method: 'POST',
      endpoint: endpoint,
      body: body,
      fromJson: fromJson,
    );
  }

  // GET request
  static Future<ApiResponseModel<T>> get<T>({
    required String endpoint,
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    return _request<T>(
      method: 'GET',
      endpoint: endpoint,
      fromJson: fromJson,
    );
  }

  // PUT request
  static Future<ApiResponseModel<T>> put<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    return _request<T>(
      method: 'PUT',
      endpoint: endpoint,
      body: body,
      fromJson: fromJson,
    );
  }

  // DELETE request
  static Future<ApiResponseModel<T>> delete<T>({
    required String endpoint,
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    return _request<T>(
      method: 'DELETE',
      endpoint: endpoint,
      fromJson: fromJson,
    );
  }
}
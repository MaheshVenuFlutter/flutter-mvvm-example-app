import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvm_example/data/exceptions.dart';
import 'package:mvvm_example/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      // No internet connection
      throw FetchDataException("No internet connection");
    } on HttpException {
      // HTTP protocol-level error
      throw FetchDataException("Couldn't find the post");
    } on FormatException {
      // Bad JSON or unexpected format
      throw FetchDataException("Bad response format");
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    Map<String, String> headerData = {
      'Content-Type': 'application/json',
      'x-api-key': 'reqres-free-v1', // Add your API key here
    };
    try {
      Response response = await http.post(Uri.parse(url), body: jsonEncode(data)
     ,headers: headerData
      );
      responseJson = returnResponse(response);
    } on SocketException {
      // No internet connection
      throw FetchDataException("No internet connection");
    } on HttpException {
      // HTTP protocol-level error
      throw FetchDataException("Couldn't find the post");
    } on FormatException {
      // Bad JSON or unexpected format
      throw FetchDataException("Bad response format");
    }

    return responseJson;
  }

  // Helper method to handle all HTTP responses
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200: // OK - Standard successful HTTP request
      case 201: // Created - Resource created successfully
        return jsonDecode(response.body);

      case 204: // No Content - Request succeeded but no content returned
        return null;

      case 400: // Bad Request - Invalid client request
        throw BadRequestException(response.body.toString());

      case 401: // Unauthorized - Authentication failed
      case 403: // Forbidden - Client does not have access rights
        throw UnauthorizedException(response.body.toString());

      case 404: // Not Found - Requested resource not available
        throw NotFoundException("Resource not found: ${response.request?.url}");

      case 408: // Request Timeout - Server timed out waiting for request
        throw RequestTimeoutException("Request timed out");

      case 422: // Unprocessable Entity - Semantic errors in request
        throw InvalidInputException(response.body.toString());

      case 500: // Internal Server Error - Generic server error
      case 502: // Bad Gateway - Invalid response from upstream server
      case 503: // Service Unavailable - Server is down or overloaded
      case 504: // Gateway Timeout - Upstream server failed to respond in time
        throw ServerErrorException(
            "Server error: ${response.statusCode}, ${response.body}");

      default: // Catch-all for any unexpected status codes
        throw FetchDataException(
            "Unexpected error: ${response.statusCode}, ${response.body}");
    }
  }
}

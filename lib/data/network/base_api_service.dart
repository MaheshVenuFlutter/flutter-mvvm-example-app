abstract class BaseApiService {
  // Method for making GET requests
  Future<dynamic> getGetApiResponse(String url);

  // Method for making POST requests with data
  Future<dynamic> getPostApiResponse(String url, dynamic data);
}

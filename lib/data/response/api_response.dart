// Importing the Status enum from the specified file path.
// This enum defines possible API states like loading, completed, or error.
import 'package:mvvm_example/data/response/status.dart';

// Declaring a generic class called ApiResponse.
// <T> makes this class flexible to hold any type of data (e.g., User, List<Product>, etc.).
class ApiResponse<T> {
  
  // The status of the API call (loading, completed, or error).
  // 'Status' is an enum you defined in 'status.dart'.
  final Status? status;

  // The actual data received from the API call.
  // This can be of any type depending on where this class is used.
  final T? data;

  // A message (usually an error message) that may come from the API or custom logic.
  final String? message;

  // Default constructor - allows you to manually assign status, data, and message.
  ApiResponse(this.status, this.data, this.message);

  // Named constructor for 'loading' state.
  // Sets status to Status.loading, and null for both data and message.
  ApiResponse.loading()
      : status = Status.loading,
        data = null,
        message = null;

  // Named constructor for 'completed' state.
  // Accepts data (of type T), sets status to Status.completed, message is null.
  ApiResponse.completed(this.data)
      : status = Status.completed,
        message = null;

  // Named constructor for 'error' state.
  // Accepts an error message, sets status to Status.error, data is null.
  ApiResponse.error(this.message)
      : status = Status.error,
        data = null;

  // Overrides the default toString() method for debugging/logging purposes.
  // Allows easy printout of status, message, and data values.
  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}

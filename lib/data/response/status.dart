// Defining an enum called Status to represent the state of an API call.
// Enums are used to define a fixed set of constant values.
enum Status {
  // Indicates the API request is currently in progress (e.g., show loading spinner in UI).
  loading,

  // Indicates the API request failed (e.g., show error message).
  error,

  // Indicates the API request completed successfully (e.g., show data in UI).
  completed,
}

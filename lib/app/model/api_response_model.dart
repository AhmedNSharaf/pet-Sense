class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;
  final int? statusCode;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.statusCode,
  });

  // Create ApiResponse from JSON (for future use)
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      statusCode: json['statusCode'],
    );
  }

  // Convert to JSON (for future use)
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'statusCode': statusCode,
    };
  }

  // Success response factory
  factory ApiResponse.success({
    required String message,
    dynamic data,
  }) {
    return ApiResponse(
      success: true,
      message: message,
      data: data,
      statusCode: 200,
    );
  }

  // Error response factory
  factory ApiResponse.error({
    required String message,
    int? statusCode,
    dynamic data,
  }) {
    return ApiResponse(
      success: false,
      message: message,
      data: data,
      statusCode: statusCode,
    );
  }

  @override
  String toString() {
    return 'ApiResponse{success: $success, message: $message, data: $data, statusCode: $statusCode}';
  }
}
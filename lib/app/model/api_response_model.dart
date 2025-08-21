class ApiResponseModel<T> {
  final bool success;
  final String message;
  final T? data;
  final int statusCode;

  ApiResponseModel({
    required this.success,
    required this.message,
    this.data,
    required this.statusCode,
  });

  factory ApiResponseModel.success({
    required String message,
    T? data,
    int statusCode = 200,
  }) {
    return ApiResponseModel<T>(
      success: true,
      message: message,
      data: data,
      statusCode: statusCode,
    );
  }

  factory ApiResponseModel.error({
    required String message,
    int statusCode = 400,
  }) {
    return ApiResponseModel<T>(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}
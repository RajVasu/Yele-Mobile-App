
class CommonModel<T> {
  final bool success;
  final String? message;
  final T? data;
  const CommonModel({required this.success, this.message, this.data});

  factory CommonModel.fromMap(
    Map<String, dynamic> data, {
    T Function(dynamic data)? handler,
    T Function(dynamic data, String? message)? handlerWithMessage,
  }) {
    return CommonModel(
      success: data['success'],
      message: data['message'],
      data:
          data['data'] == null
              ? null
              : handlerWithMessage != null
              ? handlerWithMessage(data['data'], data['message'])
              : handler?.call(data['data']),
    );
  }
}

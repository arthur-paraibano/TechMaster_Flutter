class ErrorMessage {
  int? _code;
  String? _message;

  ErrorMessage(this._code, this._message);

  int? get code => _code;
  String? get message => _message;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'code': int code, 'message': String message} => ErrorMessage(
        code,
        message,
      ),
      _ => throw const FormatException('Failed to format error message.'),
    };
  }
}

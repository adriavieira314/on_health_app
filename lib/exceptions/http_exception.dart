class HttpException implements Exception {
  final String? errorMsg;

  HttpException(this.errorMsg);

  @override
  String toString() {
    return errorMsg ??
        'Ocorreu um erro no processo. Entre em contato com suporte técnico.';
  }
}

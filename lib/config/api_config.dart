class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000', // web or desktop
    // defaultValue: 'http://172.29.160.1:8000', //mobile (must be on the same wifi)
  );
}

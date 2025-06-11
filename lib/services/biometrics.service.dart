class BiometricsService {
  // Singleton instance
  static final BiometricsService _instance = BiometricsService._internal();

  // Public factory constructor to return the same instance
  factory BiometricsService() => _instance;

  // Private constructor
  BiometricsService._internal();

  // TODO(RV): Add methods for handling biometrics. e.g. - login, clear creds, etc
}

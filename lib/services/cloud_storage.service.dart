class CloudStorageService {
  // Singleton instance
  static final CloudStorageService _instance = CloudStorageService._internal();

  // Public factory constructor to return the same instance
  factory CloudStorageService() => _instance;

  // Private constructor
  CloudStorageService._internal();

  // TODO(RV): Add methods
}

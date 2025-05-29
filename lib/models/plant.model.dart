class PlantModel {
  final String? name;
  final String? species;
  final List<dynamic>? imageUrls;
  final String? location;
  final List<dynamic>? notes;
  final int? waterIntervalDays;
  final String? lastWateredAt;
  final String? humidityPreference;
  final String? sunlightPreference;
  final String? soilType;
  final int? fertilizerIntervalDays;
  final String? lastFertilizedAt;
  final bool fertilizerReminderEnabled;
  final bool wateringReminderEnabled;
  final List<dynamic>? tags;
  final double? waterAmount;
  final bool? archived;
  final String? createdAt;
  final int? userId;

  PlantModel({
    required this.name,
    required this.fertilizerReminderEnabled,
    required this.wateringReminderEnabled,
    required this.userId,
    this.species,
    this.imageUrls,
    this.location,
    this.notes,
    this.waterIntervalDays,
    this.lastWateredAt,
    this.humidityPreference,
    this.sunlightPreference,
    this.soilType,
    this.fertilizerIntervalDays,
    this.lastFertilizedAt,
    this.tags,
    this.waterAmount,
    this.archived,
    this.createdAt,
  });

  factory PlantModel.initial() => PlantModel(
    name: null,
    species: null,
    imageUrls: <String>[],
    location: null,
    notes: null,
    waterIntervalDays: null,
    lastWateredAt: null,
    humidityPreference: null,
    sunlightPreference: null,
    soilType: null,
    fertilizerIntervalDays: null,
    lastFertilizedAt: null,
    fertilizerReminderEnabled: false,
    wateringReminderEnabled: false,
    tags: null,
    waterAmount: null,
    archived: null,
    userId: null,
  );

  factory PlantModel.fromMap(final Map<String, dynamic> json) => PlantModel(
    name: json['name'],
    species: json['species'],
    imageUrls: json['imageUrls'],
    location: json['location'],
    notes: json['notes'],
    waterIntervalDays: json['waterIntervalDays'],
    lastWateredAt: json['lastWateredAt'],
    humidityPreference: json['humidityPreference'],
    sunlightPreference: json['sunlightPreference'],
    soilType: json['soilType'],
    fertilizerIntervalDays: json['fertilierIntervalDays'],
    lastFertilizedAt: json['lastFertilizedAt'],
    fertilizerReminderEnabled: json['fertilizerReminderEnabled'] ?? false,
    wateringReminderEnabled: json['wateringReminderEnabled'] ?? false,
    tags: json['tags'],
    waterAmount: json['waterAmount'],
    archived: json['archived'],
    createdAt: json['createdAt'],
    userId: json['userId'],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'name': name,
    'species': species,
    'imageUrls': imageUrls,
    'location': location,
    'notes': notes,
    'waterIntervalDays': waterIntervalDays,
    'lastWateredAt': lastWateredAt,
    'humidityPreference': humidityPreference,
    'sunlightPreference': sunlightPreference,
    'soilType': soilType,
    'fertilierIntervalDays': fertilizerIntervalDays,
    'lastFertilizedAt': lastFertilizedAt,
    'fertilizerReminderEnabled': fertilizerReminderEnabled,
    'wateringReminderEnabled': wateringReminderEnabled,
    'tags': tags,
    'waterAmount': waterAmount,
    'archived': archived,
    'createdAt': createdAt,
    'userId': userId,
  };
}

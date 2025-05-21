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
  final int? fertilierIntervalDays;
  final String? lastFertilizedAt;
  final bool? fertilizerReminderEnabled;
  final List<dynamic>? tags;
  final double? waterAmount;
  final bool? archived;

  PlantModel({
    required this.name,
    required this.species,
    required this.imageUrls,
    required this.location,
    required this.notes,
    required this.waterIntervalDays,
    required this.lastWateredAt,
    required this.humidityPreference,
    required this.sunlightPreference,
    required this.soilType,
    required this.fertilierIntervalDays,
    required this.lastFertilizedAt,
    required this.fertilizerReminderEnabled,
    required this.tags,
    required this.waterAmount,
    required this.archived,
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
    fertilierIntervalDays: null,
    lastFertilizedAt: null,
    fertilizerReminderEnabled: null,
    tags: null,
    waterAmount: null,
    archived: null,
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
    fertilierIntervalDays: json['fertilierIntervalDays'],
    lastFertilizedAt: json['lastFertilizedAt'],
    fertilizerReminderEnabled: json['fertilizerReminderEnabled'],
    tags: json['tags'],
    waterAmount: json['waterAmount'],
    archived: json['archived'],
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
    'fertilierIntervalDays': fertilierIntervalDays,
    'lastFertilizedAt': lastFertilizedAt,
    'fertilizerReminderEnabled': fertilizerReminderEnabled,
    'tags': tags,
    'waterAmount': waterAmount,
    'archived': archived,
  };
}

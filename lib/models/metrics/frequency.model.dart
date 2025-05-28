class FrequencyModel {
  final int minFrequency;
  final int maxFrequency;
  final dynamic avgFrequency;

  FrequencyModel({
    required this.minFrequency,
    required this.maxFrequency,
    required this.avgFrequency,
  });

  factory FrequencyModel.initial() =>
      FrequencyModel(minFrequency: 0, maxFrequency: 0, avgFrequency: 0);

  factory FrequencyModel.fromMap(final Map<String, dynamic> json) =>
      FrequencyModel(
        minFrequency: json['minFrequency'],
        maxFrequency: json['maxFrequency'],
        avgFrequency: json['avgFrequency'],
      );
}

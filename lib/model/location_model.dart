import 'dart:convert';

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double longitude;
  final double latitude;
  const Location({
    required this.longitude,
    required this.latitude,
  });

  Location copyWith({
    double? longitude,
    double? latitude,
  }) {
    return Location(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() => 'Location(longitude: $longitude, latitude: $latitude)';

  @override
  List<Object> get props => [longitude, latitude];
}

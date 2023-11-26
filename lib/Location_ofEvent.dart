class Location_ofEvents {
  final String name;
  final String location;
  final String latitude;
  final String longitude;
  final String id;

  Location_ofEvents(
      this.name,
      this.location,
      this.latitude,
      this.longitude,
      this.id,
      );

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    return other is Location_ofEvents &&
        other.id == id &&
        other.name == name &&
        other.location == location &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    location.hashCode ^
    latitude.hashCode ^
    longitude.hashCode;
  }
}

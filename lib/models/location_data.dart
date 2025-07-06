/// 一个只包含我们关心的位置信息的数据模型。
class LocationData {
  final double latitude;
  final double longitude;
  final String? address; // 地址是可选的，因为可能一开始只有坐标

  LocationData({required this.latitude, required this.longitude, this.address});

  /// 一个方便的工具方法，用于创建一个新的实例并更新其中的值。
  /// 这有助于在更新状态时保持数据的不可变性。
  LocationData copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return LocationData(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}

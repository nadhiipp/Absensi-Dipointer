class AttendanceModel {
  final String id;
  final String userId;
  final DateTime date;
  final DateTime? clockInTime;
  final DateTime? clockOutTime;
  final String status; // Hadir, Izin, Alpha, Terlambat
  final double? clockInLatitude;
  final double? clockInLongitude;
  final double? clockOutLatitude;
  final double? clockOutLongitude;
  final String? clockInPhoto;
  final String? clockOutPhoto;
  final bool isWithinRadius;
  final String? notes;
  
  AttendanceModel({
    required this.id,
    required this.userId,
    required this.date,
    this.clockInTime,
    this.clockOutTime,
    required this.status,
    this.clockInLatitude,
    this.clockInLongitude,
    this.clockOutLatitude,
    this.clockOutLongitude,
    this.clockInPhoto,
    this.clockOutPhoto,
    this.isWithinRadius = true,
    this.notes,
  });
  
  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      date: DateTime.parse(json['date']),
      clockInTime: json['clockInTime'] != null 
          ? DateTime.parse(json['clockInTime']) 
          : null,
      clockOutTime: json['clockOutTime'] != null 
          ? DateTime.parse(json['clockOutTime']) 
          : null,
      status: json['status'] ?? 'Alpha',
      clockInLatitude: json['clockInLatitude']?.toDouble(),
      clockInLongitude: json['clockInLongitude']?.toDouble(),
      clockOutLatitude: json['clockOutLatitude']?.toDouble(),
      clockOutLongitude: json['clockOutLongitude']?.toDouble(),
      clockInPhoto: json['clockInPhoto'],
      clockOutPhoto: json['clockOutPhoto'],
      isWithinRadius: json['isWithinRadius'] ?? true,
      notes: json['notes'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'clockInTime': clockInTime?.toIso8601String(),
      'clockOutTime': clockOutTime?.toIso8601String(),
      'status': status,
      'clockInLatitude': clockInLatitude,
      'clockInLongitude': clockInLongitude,
      'clockOutLatitude': clockOutLatitude,
      'clockOutLongitude': clockOutLongitude,
      'clockInPhoto': clockInPhoto,
      'clockOutPhoto': clockOutPhoto,
      'isWithinRadius': isWithinRadius,
      'notes': notes,
    };
  }
  
  AttendanceModel copyWith({
    String? id,
    String? userId,
    DateTime? date,
    DateTime? clockInTime,
    DateTime? clockOutTime,
    String? status,
    double? clockInLatitude,
    double? clockInLongitude,
    double? clockOutLatitude,
    double? clockOutLongitude,
    String? clockInPhoto,
    String? clockOutPhoto,
    bool? isWithinRadius,
    String? notes,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      clockInTime: clockInTime ?? this.clockInTime,
      clockOutTime: clockOutTime ?? this.clockOutTime,
      status: status ?? this.status,
      clockInLatitude: clockInLatitude ?? this.clockInLatitude,
      clockInLongitude: clockInLongitude ?? this.clockInLongitude,
      clockOutLatitude: clockOutLatitude ?? this.clockOutLatitude,
      clockOutLongitude: clockOutLongitude ?? this.clockOutLongitude,
      clockInPhoto: clockInPhoto ?? this.clockInPhoto,
      clockOutPhoto: clockOutPhoto ?? this.clockOutPhoto,
      isWithinRadius: isWithinRadius ?? this.isWithinRadius,
      notes: notes ?? this.notes,
    );
  }
}

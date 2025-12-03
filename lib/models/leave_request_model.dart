class LeaveRequestModel {
  final String id;
  final String userId;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String status; // pending, approved, rejected
  final String? attachmentUrl;
  final DateTime createdAt;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final String? reviewNotes;
  
  LeaveRequestModel({
    required this.id,
    required this.userId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.status = 'pending',
    this.attachmentUrl,
    required this.createdAt,
    this.reviewedBy,
    this.reviewedAt,
    this.reviewNotes,
  });
  
  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      leaveType: json['leaveType'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      reason: json['reason'] ?? '',
      status: json['status'] ?? 'pending',
      attachmentUrl: json['attachmentUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      reviewedBy: json['reviewedBy'],
      reviewedAt: json['reviewedAt'] != null 
          ? DateTime.parse(json['reviewedAt']) 
          : null,
      reviewNotes: json['reviewNotes'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'leaveType': leaveType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'reason': reason,
      'status': status,
      'attachmentUrl': attachmentUrl,
      'createdAt': createdAt.toIso8601String(),
      'reviewedBy': reviewedBy,
      'reviewedAt': reviewedAt?.toIso8601String(),
      'reviewNotes': reviewNotes,
    };
  }
  
  int get durationDays {
    return endDate.difference(startDate).inDays + 1;
  }
  
  LeaveRequestModel copyWith({
    String? id,
    String? userId,
    String? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    String? reason,
    String? status,
    String? attachmentUrl,
    DateTime? createdAt,
    String? reviewedBy,
    DateTime? reviewedAt,
    String? reviewNotes,
  }) {
    return LeaveRequestModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      createdAt: createdAt ?? this.createdAt,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewNotes: reviewNotes ?? this.reviewNotes,
    );
  }
}

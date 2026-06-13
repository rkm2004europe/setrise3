enum VerificationStatus { pending, approved, rejected }

class DateVerificationModel {
  final String userId;
  final VerificationStatus status;
  final DateTime submittedAt;
  final String? rejectionReason;

  DateVerificationModel({
    required this.userId,
    required this.status,
    required this.submittedAt,
    this.rejectionReason,
  });
}

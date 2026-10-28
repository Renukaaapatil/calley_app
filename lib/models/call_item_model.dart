class CallItemModel {
  final String firstName;
  final String lastName;
  final String title;
  final String phone;
  final String? otherPhone1;
  final String email;
  final String address;
  final String company;
  final int? age;
  final String? zip;
  final String? maritalStatus;
  final String? notes;
  final String? calledAt;
  final String? rescheduledAt;
  final String? createdAt;
  String status; // 'pending', 'called', 'rescheduled'
  final String? agentName;
  final int? duration;
  String? feedback;

  CallItemModel({
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.phone,
    this.otherPhone1,
    required this.email,
    required this.address,
    required this.company,
    this.age,
    this.zip,
    this.maritalStatus,
    this.notes,
    this.calledAt,
    this.rescheduledAt,
    this.createdAt,
    required this.status,
    this.agentName,
    this.duration,
    this.feedback,
  });

  String get fullName => '$title $firstName $lastName'.trim();

  factory CallItemModel.fromJson(Map<String, dynamic> json) {
    return CallItemModel(
      firstName: json['FirstName'] ?? json['firstName'] ?? '',
      lastName: json['LastName'] ?? json['lastName'] ?? '',
      title: json['Title'] ?? json['title'] ?? '',
      phone: json['Phone']?.toString() ?? json['phone']?.toString() ?? '',
      otherPhone1: json['Other Phone 1']?.toString() ?? json['otherPhone1']?.toString(),
      email: json['Email'] ?? json['email'] ?? '',
      address: json['Address'] ?? json['address'] ?? '',
      company: json['Company'] ?? json['company'] ?? '',
      age: json['Age'] is int ? json['Age'] : int.tryParse(json['Age']?.toString() ?? ''),
      zip: json['Zip']?.toString(),
      maritalStatus: json['MaritalStatus'] ?? json['maritalStatus'],
      notes: json['Notes'] ?? json['notes'],
      calledAt: json['calledAt'],
      rescheduledAt: json['rescheduledAt'],
      createdAt: json['createdAt'],
      status: json['status'] ?? 'pending',
      agentName: json['agentName'],
      duration: json['duration'] is int ? json['duration'] : int.tryParse(json['duration']?.toString() ?? ''),
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Title': title,
      'Phone': phone,
      'Other Phone 1': otherPhone1,
      'Email': email,
      'Address': address,
      'Company': company,
      'Age': age,
      'Zip': zip,
      'MaritalStatus': maritalStatus,
      'Notes': notes,
      'calledAt': calledAt,
      'rescheduledAt': rescheduledAt,
      'createdAt': createdAt,
      'status': status,
      'agentName': agentName,
      'duration': duration,
      'feedback': feedback,
    };
  }
}

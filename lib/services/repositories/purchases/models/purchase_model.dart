import 'package:cloud_firestore/cloud_firestore.dart';

class Purchase {
  String purchaseId;
  String userId;
  String petId;
  String itemType;
  String itemId;
  DateTime purchaseDate;
  DateTime? appointmentDate;
  String status;

  Purchase({
    required this.purchaseId,
    required this.userId,
    required this.petId,
    required this.itemType,
    required this.itemId,
    required this.purchaseDate,
    this.appointmentDate,
    required this.status,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      purchaseId: json['purchaseId'],
      userId: json['userId'],
      petId: json['petId'],
      itemType: json['itemType'],
      itemId: json['itemId'],
      purchaseDate: (json['purchaseDate'] as Timestamp).toDate(),
      appointmentDate: json['appointmentDate'] != null ? (json['appointmentDate'] as Timestamp).toDate() : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'purchaseId': purchaseId,
      'userId': userId,
      'petId': petId,
      'itemType': itemType,
      'itemId': itemId,
      'purchaseDate': Timestamp.fromDate(purchaseDate),
      'appointmentDate': appointmentDate != null ? Timestamp.fromDate(appointmentDate!) : null,
      'status': status,
    };
  }
}

class Appointment {
  String appointmentId;
  String purchaseId;
  String userId;
  String petId;
  String serviceProviderId;
  DateTime appointmentDate;
  bool notificationSent;
  String status;

  Appointment({
    required this.appointmentId,
    required this.purchaseId,
    required this.userId,
    required this.petId,
    required this.serviceProviderId,
    required this.appointmentDate,
    required this.notificationSent,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      purchaseId: json['purchaseId'],
      userId: json['userId'],
      petId: json['petId'],
      serviceProviderId: json['serviceProviderId'],
      appointmentDate: (json['appointmentDate'] as Timestamp).toDate(),
      notificationSent: json['notificationSent'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'purchaseId': purchaseId,
      'userId': userId,
      'petId': petId,
      'serviceProviderId': serviceProviderId,
      'appointmentDate': Timestamp.fromDate(appointmentDate),
      'notificationSent': notificationSent,
      'status': status,
    };
  }
}

class ServiceProvider {
  String providerId;
  String name;
  String email;
  String phone;
  String serviceType;
  String availability;

  ServiceProvider({
    required this.providerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.serviceType,
    required this.availability,
  });

  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      providerId: json['providerId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      serviceType: json['serviceType'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'providerId': providerId,
      'name': name,
      'email': email,
      'phone': phone,
      'serviceType': serviceType,
      'availability': availability,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ploofypaws/services/repositories/purchases/models/purchase_model.dart';


class PurchaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Purchases CRUD
  Future<void> addPurchase(Purchase purchase) {
    return _db.collection('Purchases').doc(purchase.purchaseId).set(purchase.toJson());
  }

  Future<Purchase?> getPurchase(String purchaseId) async {
    DocumentSnapshot doc = await _db.collection('Purchases').doc(purchaseId).get();
    if (doc.exists) {
      return Purchase.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updatePurchase(Purchase purchase) {
    return _db.collection('Purchases').doc(purchase.purchaseId).update(purchase.toJson());
  }

  Future<void> deletePurchase(String purchaseId) {
    return _db.collection('Purchases').doc(purchaseId).delete();
  }

  // Appointments CRUD
  Future<void> addAppointment(Appointment appointment) {
    return _db.collection('Appointments').doc(appointment.appointmentId).set(appointment.toJson());
  }

  Future<Appointment?> getAppointment(String appointmentId) async {
    DocumentSnapshot doc = await _db.collection('Appointments').doc(appointmentId).get();
    if (doc.exists) {
      return Appointment.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateAppointment(Appointment appointment) {
    return _db.collection('Appointments').doc(appointment.appointmentId).update(appointment.toJson());
  }

  Future<void> deleteAppointment(String appointmentId) {
    return _db.collection('Appointments').doc(appointmentId).delete();
  }

  // ServiceProviders CRUD
  Future<void> addServiceProvider(ServiceProvider serviceProvider) {
    return _db.collection('ServiceProviders').doc(serviceProvider.providerId).set(serviceProvider.toJson());
  }

  Future<ServiceProvider?> getServiceProvider(String providerId) async {
    DocumentSnapshot doc = await _db.collection('ServiceProviders').doc(providerId).get();
    if (doc.exists) {
      return ServiceProvider.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateServiceProvider(ServiceProvider serviceProvider) {
    return _db.collection('ServiceProviders').doc(serviceProvider.providerId).update(serviceProvider.toJson());
  }

  Future<void> deleteServiceProvider(String providerId) {
    return _db.collection('ServiceProviders').doc(providerId).delete();
  }
}

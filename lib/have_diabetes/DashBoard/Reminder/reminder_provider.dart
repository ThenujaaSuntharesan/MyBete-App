import 'package:flutter/material.dart';
import 'package:mybete_app/have_diabetes/DashBoard/Reminder/reminder_model.dart';
import 'package:mybete_app/have_diabetes/DashBoard/Reminder/reminder_service.dart';

class ReminderProvider with ChangeNotifier {
  final ReminderService _reminderService = ReminderService();
  List<Reminder> _reminders = [];
  bool _isLoading = false;
  String? _error;

  List<Reminder> get reminders => _reminders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ReminderProvider() {
    loadReminders();
  }

  // 🔹 Load Reminders from Firestore
  void loadReminders() {
    _isLoading = true;
    notifyListeners();

    _reminderService.getReminders().listen(
            (reminders) {
          _reminders = reminders;
          _isLoading = false;
          _error = null;
          notifyListeners();
        },
        onError: (error) {
          _isLoading = false;
          _error = "Failed to load reminders: ${error.toString()}";
          notifyListeners();
        }
    );
  }

  // 🔹 Add Reminder
  Future<bool> addReminder(Reminder reminder) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _reminderService.addReminder(reminder);
      _isLoading = false;
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = "Failed to add reminder: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

  // 🔹 Update Reminder
  Future<bool> updateReminder(Reminder reminder) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _reminderService.updateReminder(reminder);
      _isLoading = false;
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = "Failed to update reminder: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

  // 🔹 Delete Reminder
  Future<bool> deleteReminder(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _reminderService.deleteReminder(id);
      _isLoading = false;
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = "Failed to delete reminder: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

  // 🔹 Toggle Reminder Active Status
  Future<bool> toggleReminderActive(String id, bool isActive) async {
    try {
      await _reminderService.toggleReminderActive(id, isActive);

      // Update the local list
      final index = _reminders.indexWhere((reminder) => reminder.id == id);
      if (index != -1) {
        _reminders[index] = _reminders[index].copyWith(isActive: isActive);
        notifyListeners();
      }

      return true;
    } catch (e) {
      _error = "Failed to update reminder status: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

  // 🔹 Get a single reminder by ID
  Future<Reminder?> getReminderById(String id) async {
    try {
      return await _reminderService.getReminderById(id);
    } catch (e) {
      _error = "Failed to get reminder: ${e.toString()}";
      notifyListeners();
      return null;
    }
  }

  // 🔹 Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}



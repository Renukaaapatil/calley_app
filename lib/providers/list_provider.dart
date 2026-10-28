import 'package:flutter/foundation.dart';
import '../models/calling_list_model.dart';
import '../models/list_details_model.dart';
import '../models/call_item_model.dart';
import '../services/api_service.dart';

class ListProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<CallingListModel> _lists = [];
  CallingListModel? _selectedList;
  ListDetailsModel? _listDetails;
  bool _isLoading = false;
  String? _errorMessage;

  List<CallingListModel> get lists => _lists;
  CallingListModel? get selectedList => _selectedList;
  ListDetailsModel? get listDetails => _listDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchLists(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _lists = await _apiService.getLists(userId);
      if (_lists.isNotEmpty) {
        _selectedList = _lists.first;
        await fetchListDetails(_selectedList!.id);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectList(CallingListModel list) async {
    _selectedList = list;
    notifyListeners();
    await fetchListDetails(list.id);
  }

  Future<void> fetchListDetails(String listId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _listDetails = await _apiService.getListDetails(listId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update call item status (for interactive simulation)
  void updateCallStatus(int index, String newStatus, {String? feedback}) {
    if (_listDetails == null || index >= _listDetails!.calls.length) return;

    final oldStatus = _listDetails!.calls[index].status;
    _listDetails!.calls[index].status = newStatus;
    if (feedback != null) {
      _listDetails!.calls[index].feedback = feedback;
    }

    // Update counts
    if (oldStatus == 'pending') _listDetails!.pending--;
    if (oldStatus == 'called') _listDetails!.called--;
    if (oldStatus == 'rescheduled') _listDetails!.rescheduled--;

    if (newStatus == 'pending') _listDetails!.pending++;
    if (newStatus == 'called') _listDetails!.called++;
    if (newStatus == 'rescheduled') _listDetails!.rescheduled++;

    notifyListeners();
  }
}

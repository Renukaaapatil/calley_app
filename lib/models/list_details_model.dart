import 'call_item_model.dart';

class ListDetailsModel {
  int pending;
  int called;
  int rescheduled;
  final List<CallItemModel> calls;

  ListDetailsModel({
    required this.pending,
    required this.called,
    required this.rescheduled,
    required this.calls,
  });

  int get totalCalls => pending + called + rescheduled;

  factory ListDetailsModel.fromJson(Map<String, dynamic> json) {
    List<CallItemModel> parsedCalls = [];
    if (json['calls'] != null && json['calls'] is List) {
      parsedCalls = (json['calls'] as List)
          .map((item) => CallItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return ListDetailsModel(
      pending: json['pending'] is int ? json['pending'] : int.tryParse(json['pending']?.toString() ?? '0') ?? 0,
      called: json['called'] is int ? json['called'] : int.tryParse(json['called']?.toString() ?? '0') ?? 0,
      rescheduled: json['rescheduled'] is int ? json['rescheduled'] : int.tryParse(json['rescheduled']?.toString() ?? '0') ?? 0,
      calls: parsedCalls,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending': pending,
      'called': called,
      'rescheduled': rescheduled,
      'calls': calls.map((c) => c.toJson()).toList(),
    };
  }
}

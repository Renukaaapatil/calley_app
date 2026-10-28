class CallingListModel {
  final String id;
  final String name;
  final List<dynamic> agents;
  final String clientId;

  CallingListModel({
    required this.id,
    required this.name,
    required this.agents,
    required this.clientId,
  });

  factory CallingListModel.fromJson(Map<String, dynamic> json) {
    return CallingListModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? 'Default List',
      agents: json['agents'] != null ? List<dynamic>.from(json['agents']) : [],
      clientId: json['clientId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'agents': agents,
      'clientId': clientId,
    };
  }
}

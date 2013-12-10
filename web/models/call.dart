part of webpuzzle;

class Call {
  String id;
  String name;
  List<AgendaItem> agenda = [];

  bool get valid => name.isNotEmpty;
}

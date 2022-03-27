class Config {
  static final Config _instance = Config._internal();
  Map<String, dynamic> items = {};
  factory Config(Map<String, dynamic> options) {
    _instance.items = options;
    return _instance;
  }
  factory Config.s() {
    return _instance;
  }

  Config._internal() {}
  bool get tostring => items["to_string"];
  bool get immutable => items["immutable"];
}

class AnonymousCounter {
  int counter = 0;
  List<dynamic> structs = [];
  static final AnonymousCounter _instance = AnonymousCounter._internal();

  factory AnonymousCounter() {
    return _instance;
  }

  AnonymousCounter._internal() {}

  reset() {
    this.counter = 0;
    this.structs = [];
  }

  int get() {
    this.counter = counter + 1;
    return counter;
  }

  add(dynamic s) {
    structs.add(s);
  }

  sanitize() {
    List<dynamic> newstructs = [];
    List<String> structNames = [];
    structs.forEach((element) {
      if (structNames.contains(element.name)) {
      } else {
        newstructs.add(element);
        structNames.add(element.name);
      }
    });
    structs = newstructs;
  }

  @override
  String toString() => 'Counter: ${counter}, ${structs}';
}

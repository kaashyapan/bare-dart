import 'package:recase/recase.dart';

class AstEnum {
  late String name;
  late List<AstEnumMember> fields = List.empty();
  AstEnum({required this.name, required this.fields});

  @override
  String toString() {
    return 'AstEnum: ${name}, Members - ${fields}';
  }

  String getDecl() {
    sanitize();
    return name;
  }

  String toModel() {
    sanitize();
    var buffer = StringBuffer();
    buffer.writeln('enum ${name} {');
    fields.forEach((element) {
      buffer.writeln('${element.name},');
    });
    buffer.writeln('}');
    return buffer.toString();
  }

  String toMethod() {
    sanitize();
    var buffer = StringBuffer();
    buffer.writeln('''
      extension ${name}Bare on ${name} { 
        Packer pack(Packer p) {
          p.packUint64(Int64(_getBareIdx));
          return p;
        }
 
        Uint8List toBare() {
          final x = Packer();
          pack(x);
          return x.takeBytes();
        }

        static ${name} fromBare(data) {
          Unpacker unpacker = Unpacker.fromList(data);
          return unpack(unpacker);
        }
      ''');

    // FromBare
    buffer.writeln('''
      static ${name} unpack(Unpacker data) {
        final bareIdx = data.unpackUint64().toInt();
    ''');

    fields.forEach((f) {
      buffer.writeln('if (bareIdx == ${f.idx}) return ${name + '.' + f.name};');
    });
    buffer.writeln(" throw ('Invalid ${name} enum option');");
    buffer.writeln('}');

    buffer.writeln('''
      int get _getBareIdx {
        switch (this) {
    ''');

    fields.forEach((f) {
      buffer.writeln('case ${name + '.' + f.name}: return ${f.idx};');
    });
    buffer.writeln(" default: throw ('Invalid ${name} enum option');");
    buffer.writeln('}');
    buffer.writeln('}');

    buffer.writeln('}');
    return buffer.toString();
  }

  sanitize() {
    var idx = 0;
    name = name.trim().pascalCase;
    fields.forEach((e) {
      idx = e.idx ?? idx;
      e.idx = idx;
      e.name = e.name.trim().constantCase;
      idx++;
    });
    return this;
  }
}

class AstEnumMember {
  late String name;
  late int? idx;
  AstEnumMember({required this.name, required this.idx});

  @override
  String toString() {
    return 'AstEnumMember: ${name} - ${idx}';
  }
}

import 'package:recase/recase.dart';
import 'package:bare_codegen/src/class_generator/anonymous.dart';

class AstUnion {
  late String name;
  bool anonymous = false;
  late List<AstUnionMember> fields = List.empty();
  AstUnion({required this.name, required this.fields, this.anonymous = false});

  @override
  String toString() {
    return 'AstUnion: ${name}, Members - ${fields}';
  }

  String getDecl() {
    sanitize();
    return name;
  }

  String toModel() {
    sanitize();
    var buffer = StringBuffer();
    final immutable = Config.s().immutable;

    buffer.writeln('enum ${name}Kind {');
    fields.forEach((element) {
      buffer.writeln('${element.name.constantCase},');
    });
    buffer.writeln('}');

    if (immutable) buffer.writeln('@immutable');

    buffer.writeln('class ${name} {');
    if (immutable)
      buffer.writeln('''
              final ${name}Kind kind;
              final dynamic value;
            ''');
    else
      buffer.writeln('''
              ${name}Kind kind;
              dynamic value;
            ''');

    buffer.writeln('''
        ${name}({required this.kind, required this.value});
        
        static ${name} fromBare(data) => ${name}Bare.fromBare(data);
    ''');

    if (immutable) {
      buffer.writeln('''

          @override
          bool operator ==(other) {
            return (other is ${name}) && other.kind == kind && other.value == value;
        ''');
      buffer.writeln('}');

      //Generate hashcode
      buffer.writeln('''

          @override
          int get hashCode => Object.hash(${name}, kind, value);
        ''');
    }

    if (Config.s().tostring == true) {
      //Generate toString
      buffer.writeln(''' 
      @override
      String toString() => '\$\{kind\}  \$\{value\}';
    ''');
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  String toMethod() {
    sanitize();
    var buffer = StringBuffer();
    buffer.writeln('''
      extension ${name}Bare on ${name} { 
 
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
    buffer.writeln('''
        Packer pack(Packer p) {
          final bareIdx = kind.getBareIdx;
          p.packUint64(Int64(bareIdx));
    ''');

    fields.forEach((f) {
      buffer.writeln('if (bareIdx == ${f.idx}) (value as ${f.name}).pack(p);');
    });

    buffer.writeln('''
          return p;
        }
    ''');

    buffer.writeln('''
      static ${name} unpack(Unpacker p) {
        final bareIdx = p.unpackUint64().toInt();
    ''');

    fields.forEach((f) {
      buffer.writeln('''
        if (bareIdx == ${f.idx}) {
          final _kind = ${name}Kind.${f.name.constantCase};
          final _value = ${f.name}Bare.unpack(p);
          return ${name}(kind: _kind, value: _value);
        }
        ''');
    });
    buffer.writeln("throw ('Invalid ${name} union option -  \$\{bareIdx\}');");
    buffer.writeln('}');

    buffer.writeln('}');

    buffer.writeln('''
      extension ${name}KindBare on ${name}Kind { 
  ''');
    buffer.writeln('''
      int get getBareIdx {
    ''');

    fields.forEach((f) {
      buffer.writeln(
          'if (this == ${name + 'Kind.' + f.name.constantCase}) return ${f.idx};');
    });
    buffer.writeln("throw ('Invalid ${name} union option - \$\{this\}');");
    buffer.writeln('}');

    buffer.writeln('}');
    return buffer.toString();
  }

  packMethod(namestr) {
    sanitize();
    return '${namestr}.pack(p)';
  }

  String unpackMethod(namestr) {
    sanitize();
    return 'final ${namestr} = ${name}Bare.unpack(p)';
  }

  sanitize() {
    var idx = 0;
    name = name.trim().pascalCase;

    name = name.replaceAll('-', '');

    fields.forEach((e) {
      idx = e.idx ?? idx;
      e.idx = idx;
      e.name = e.name.trim();
      idx++;
    });
    return this;
  }
}

class AstUnionMember {
  late String name;
  late int? idx;
  AstUnionMember({required this.name, required this.idx});

  @override
  String toString() {
    return 'AstUnionMember: ${name} - ${idx}';
  }
}

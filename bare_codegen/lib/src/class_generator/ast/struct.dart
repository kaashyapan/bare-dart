import 'package:bare_codegen/src/class_generator/ast.dart';
import 'package:recase/recase.dart';
import 'package:bare_codegen/src/class_generator/anonymous.dart';

class AstStruct {
  late String name;
  late List<AstStructMember> fields = List.empty();
  AstStruct({required this.name, required this.fields});

  @override
  String toString() {
    return 'AstStruct: ${name}, Members - ${fields}';
  }

  String getDecl() {
    sanitize();
    return name;
  }

  String toModel() {
    sanitize();
    var buffer = StringBuffer();
    var props = [];
    final immutable = Config.s().immutable;
    if (immutable) buffer.writeln('@immutable');

    buffer.writeln('class ${name} {');
    fields.forEach((e) {
      final String type_ = e.type_.getDecl();
      if (immutable)
        buffer.writeln('final ' + type_ + ' ' + e.name + ';');
      else
        buffer.writeln(type_ + ' ' + e.name + ';');

      if (type_.endsWith('?')) {
        props.add('this.${e.name}');
      } else {
        props.add('required this.${e.name}');
      }
    });
    final proplist = props.join(', ');
    buffer.writeln('${name} ({${proplist}});');
    buffer.writeln('''
        
        static ${name} fromBare(data) => ${name}Bare.fromBare(data);
        ''');
    if (immutable) {
      //Generate Equals
      final equals = <String>[];
      fields.forEach((e) => equals.add('other.${e.name} == ${e.name}'));

      buffer.writeln('''

      @override
      bool operator ==(other) {
        return (other is ${name}) && ${equals.join(' && ')};
    ''');

      buffer.writeln('}');

      //Generate hashcode

      final hashcode = <String>[];
      fields.forEach((e) => hashcode.add('${e.name}'));
      buffer.writeln('''

      @override
      int get hashCode => Object.hash(${hashcode.join(', ')});
    ''');
    }

    if (Config.s().tostring == true) {
      //Generate tostring

      final tostring = <String>[];
      fields.forEach((e) => tostring.add('${e.name}: \$\{${e.name}\}'));
      buffer.writeln('''
    
      @override
      String toString() => 
    ''');
      buffer.writeln("\'$name { ${tostring.join(', ')} }\';");
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  String toMethod() {
    sanitize();

    var buffer = StringBuffer();
    buffer.writeln('extension ${name}Bare on ${name} {');
    buffer.writeln('''
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
    buffer.writeln('Packer pack(Packer p) {');
    var props = [];

    fields.forEach((f) {
      if (f.type_ is AstPrimitiveType)
        buffer.writeln(f.type_.packMethod(f.name) + ';');
      if (f.type_ is AstByteDataType)
        buffer.writeln(f.type_.packMethod(f.name) + ';');
      if (f.type_ is AstOptionalType)
        buffer.writeln(f.type_.packMethod(f.name) + ';');
      if (f.type_ is AstListType) buffer.writeln(f.type_.packMethod(f.name));
      if (f.type_ is AstMapType) buffer.writeln(f.type_.packMethod(f.name));
      if (f.type_ is AstUserDefinedType)
        buffer.writeln(f.type_.packMethod(f.name) + ';');
      if (f.type_ is AstStruct)
        buffer.writeln(f.type_.packMethod(f.name) + ';');
      if (f.type_ is AstUnion) buffer.writeln(f.type_.packMethod(f.name) + ';');
    });
    buffer.writeln('return p;}');

    buffer.writeln('static ${name} unpack(Unpacker p) {');
    fields.forEach((f) {
      if (f.type_ is AstPrimitiveType)
        buffer.writeln(f.type_.unpackMethod(f.name) + ';');
      if (f.type_ is AstByteDataType)
        buffer.writeln(f.type_.unpackMethod(f.name) + ';');
      if (f.type_ is AstOptionalType)
        buffer.writeln(f.type_.unpackMethod(f.name) + ';');
      if (f.type_ is AstListType) {
        buffer.writeln('''
          ${f.type_.getDecl()} ${f.name};
          ${f.type_.unpackMethod(f.name)}
        ''');
      }
      if (f.type_ is AstMapType) {
        buffer.writeln('''
          ${f.type_.getDecl()} ${f.name}; 
          ${f.type_.unpackMethod(f.name)}
        ''');
      }
      if (f.type_ is AstUserDefinedType) {
        buffer.writeln('''
          ${f.type_.getDecl()} ${f.name}; 
          ${f.type_.unpackMethod(f.name)};
        ''');
      }
      if (f.type_ is AstStruct)
        buffer.writeln(f.type_.unpackMethod(f.name) + ';');

      if (f.type_ is AstUnion)
        buffer.writeln(f.type_.unpackMethod(f.name) + ';');

      props.add('${f.name}: ${f.name}');
    });

    final proplist = props.join(', ');

    buffer.writeln('return ${name}(${proplist});');

    buffer.writeln('}');

    buffer.writeln('}');
    return buffer.toString();
  }

  packMethod(namestr) {
    sanitize();
    if (name.startsWith('Anon')) AnonymousCounter().add(this);

    return '${namestr}.pack(p)';
  }

  String unpackMethod(namestr) {
    sanitize();
    return 'final ${namestr} = ${name}Bare.unpack(p)';
  }

  sanitize() {
    name = name.trim().pascalCase;
    if (name == 'Anon') {
      name = name + AnonymousCounter().get().toString();
    }
    name = name.replaceAll('-', '');
    return this;
  }
}

class AstStructMember {
  late String name;
  late dynamic type_;
  AstStructMember({required this.name, required this.type_});

  @override
  String toString() {
    return 'AstStructMember: ${name} - ${type_}';
  }

  sanitize() {
    name = name.trim().pascalCase;
    type_ = type_.sanitize();
  }
}

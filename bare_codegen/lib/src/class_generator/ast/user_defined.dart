import 'package:recase/recase.dart';
import 'package:bare_codegen/src/class_generator/ast.dart';
import 'package:bare_codegen/src/class_generator/anonymous.dart';

class AstUserClass {
  late String name;
  late dynamic type_;

  AstUserClass({required this.name, required this.type_});

  String toString() => 'AstUserClass - ${name} , ${type_}';

  sanitize() {
    name = name.pascalCase;
  }

  String getDecl() {
    sanitize();
    return name;
  }

  String toModel() {
    sanitize();
    var buffer = StringBuffer();
    final immutable = Config.s().immutable;
    var props = [];
    if (immutable) buffer.writeln('@immutable');
    buffer.writeln(' class ${name} {');

    if (type_ is AstVoidType) {
      buffer.writeln('${name} ();   // Bare void type');
    } else {
      final String typdecl_ = type_.getDecl();

      if (immutable)
        buffer.writeln('final ' + typdecl_ + ' ' + 'value' + ';');
      else
        buffer.writeln(typdecl_ + ' ' + 'value' + ';');

      if (typdecl_.endsWith('?')) {
        props.add('this.value');
      } else {
        props.add('required this.value');
      }

      final proplist = props.join(', ');
      buffer.writeln('${name} ({${proplist}});');
      buffer.writeln('''

        static ${name} fromBare(data) => ${name}Bare.fromBare(data);
        ''');

      if (immutable) {
        buffer.writeln('''

          @override
          bool operator ==(other) {
            return (other is ${name}) && other.value == value;
        ''');
        buffer.writeln('}');

        //Generate hashcode
        buffer.writeln('''

          @override
          int get hashCode => Object.hash("${name}", value);
        ''');
      }

      if (Config.s().tostring == true) {
        buffer.writeln("String toString() => '${name} {\$\{value\}}';");
      }
    }

    buffer.writeln('}');

    return buffer.toString();
  }

  String toMethod() {
    sanitize();
    var buffer = StringBuffer();
    if (type_ is AstVoidType) {
      buffer.writeln('extension ${name}Bare on ${name} {');
      buffer.writeln('Packer pack(Packer p) {return p;}');
      buffer.writeln('static ${name} unpack(Unpacker p) {');
      buffer.writeln('return ${name}();');
      buffer.writeln('}');
      buffer.writeln('}');
    } else {
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
      if (type_ is AstVoidType) buffer.writeln(type_.packMethod('value') + ';');
      if (type_ is AstPrimitiveType)
        buffer.writeln(type_.packMethod('value') + ';');
      if (type_ is AstByteDataType)
        buffer.writeln(type_.packMethod('value') + ';');
      if (type_ is AstOptionalType)
        buffer.writeln(type_.packMethod('value') + ';');
      if (type_ is AstListType) buffer.writeln(type_.packMethod('value'));
      if (type_ is AstMapType) buffer.writeln(type_.packMethod('value'));
      if (type_ is AstUserDefinedType)
        buffer.writeln(type_.packMethod('value') + ';');

      buffer.writeln('return p;}');

      buffer.writeln('static ${name} unpack(Unpacker p) {');
      if (type_ is AstVoidType) buffer.writeln(type_.packMethod('value') + ';');
      if (type_ is AstPrimitiveType)
        buffer.writeln(type_.unpackMethod('value') + ';');
      if (type_ is AstByteDataType)
        buffer.writeln(type_.unpackMethod('value') + ';');
      if (type_ is AstOptionalType)
        buffer.writeln(type_.unpackMethod('value') + ';');
      if (type_ is AstListType) {
        buffer.writeln('''
          ${type_.getDecl()} ${'value'};
          ${type_.unpackMethod('value')}
        ''');
      }
      if (type_ is AstMapType) {
        buffer.writeln('''
          ${type_.getDecl()} ${'value'};
          ${type_.unpackMethod('value')}
        ''');
      }
      if (type_ is AstUserDefinedType) {
        buffer.writeln('''
          ${type_.name} ${'value'};
          ${type_.unpackMethod('value')};
        ''');
      }

      props.add('${'value'}: ${'value'}');

      final proplist = props.join(', ');

      buffer.writeln('return ${name}(${proplist});');

      buffer.writeln('}');

      buffer.writeln('}');
    }
    return buffer.toString();
  }

  String packMethod(namestr) {
    sanitize();
    return '${namestr}.pack(p);';
  }

  String unpackMethod(namestr) {
    sanitize();
    return '${namestr} = ${namestr}.unpack(p)';
  }
}

class AstUserDefinedType {
  late String name;
  AstUserDefinedType({required this.name});

  String toString() => 'AstUserDefinedType - ${name}';

  sanitize() {
    name = name.trim().pascalCase;
  }

  String getDecl() {
    sanitize();
    return name;
  }

  String toModel() {
    sanitize();
    return '// AstUserDefinedType - ${name}';
  }

  String toMethod() {
    return '// AstUserDefinedType - ${name}';
  }

  String packMethod(namestr) {
    sanitize();
    return '${namestr}.pack(p)';
  }

  String unpackMethod(namestr) {
    sanitize();
    return '${namestr} = ${name}Bare.unpack(p)';
  }
}

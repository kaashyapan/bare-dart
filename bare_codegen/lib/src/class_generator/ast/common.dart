import 'package:bare_codegen/src/class_generator/ast.dart';

class AstVoidType {
  AstVoidType();
  @override
  String toString() {
    return 'AstVoid - void';
  }

  sanitize() {
    return;
  }

  getDecl() => {'dynamic'};
  String packMethod(String namestr) => '';
  String unpackMethod(String namestr) => '';
}

class AstPrimitiveType {
  late String name;
  AstPrimitiveType({required this.name});

  String toString() => 'AstPrimitiveType - ${name}';
  sanitize() {
    name = name.trim();
  }

  getDecl() {
    sanitize();
    if (name == 'str') return 'String';
    if (name == 'i8') return 'int';
    if (name == 'i16') return 'int';
    if (name == 'i32') return 'int';
    if (name == 'i64') return 'Int64';
    if (name == 'int') return 'Int64';
    if (name == 'u8') return 'int';
    if (name == 'u16') return 'int';
    if (name == 'u32') return 'int';
    if (name == 'u64') return 'Int64';
    if (name == 'uint') return 'Int64';
    if (name == 'f32') return 'double';
    if (name == 'f64') return 'double';
    if (name == 'bool') return 'bool';

    throw 'Unable to decode primitive';
  }

  String packMethod(String namestr) {
    sanitize();
    namestr = namestr.trim();
    if (name == 'str') return 'p.packString(${namestr})';
    if (name == 'i8') return 'p.packInt8(${namestr})';
    if (name == 'i16') return 'p.packInt16(${namestr})';
    if (name == 'i32') return 'p.packInt32(${namestr})';
    if (name == 'i64') return 'p.packInt64(${namestr})';
    if (name == 'int') return 'p.packInt64(${namestr})';
    if (name == 'u8') return 'p.packUint8(${namestr})';
    if (name == 'u16') return 'p.packUint16(${namestr})';
    if (name == 'u32') return 'p.packUint32(${namestr})';
    if (name == 'u64') return 'p.packUint64(${namestr})';
    if (name == 'uint') return 'p.packUint64(${namestr})';
    if (name == 'f32') return 'p.packFloat(${namestr})';
    if (name == 'f64') return 'p.packDouble(${namestr})';
    if (name == 'bool') return 'p.packBool(${namestr})';

    throw 'Unable to decode primitive';
  }

  String unpackMethod(String namestr) {
    sanitize();
    namestr = namestr.trim();
    if (name == 'str') return 'final ${namestr} = p.unpackString()';
    if (name == 'i8') return 'final ${namestr} = p.unpackInt8()';
    if (name == 'i16') return 'final ${namestr} = p.unpackInt16()';
    if (name == 'i32') return 'final ${namestr} = p.unpackInt32()';
    if (name == 'i64') return 'final ${namestr} = p.unpackInt64()';
    if (name == 'int') return 'final ${namestr} = p.unpackInt64()';
    if (name == 'u8') return 'final ${namestr} = p.unpackUint8()';
    if (name == 'u16') return 'final ${namestr} = p.unpackUint16()';
    if (name == 'u32') return 'final ${namestr} = p.unpackUint32()';
    if (name == 'u64') return 'final ${namestr} = p.unpackUint64()';
    if (name == 'uint') return 'final ${namestr} = p.unpackUint64()';
    if (name == 'f32') return 'final ${namestr} = p.unpackFloat()';
    if (name == 'f64') return 'final ${namestr} = p.unpackDouble()';
    if (name == 'bool') return 'final ${namestr} = p.unpackBool()';

    throw 'Unable to decode primitive';
  }
}

class AstByteDataType {
  late int? size;
  AstByteDataType({required this.size});

  String toString() => 'AstByteDataType - ${size}';
  sanitize() {
    return;
  }

  getDecl() {
    return 'List<int>';
  }

  packMethod(namestr) {
    if (this.size == null)
      return 'p.packBinary(${namestr})';
    else
      return 'p.packBinaryFixedLength(${this.size}, ${namestr})';
  }

  unpackMethod(namestr) {
    if (this.size == null)
      return 'final ${namestr} = p.unpackBinary()';
    else
      return 'final ${namestr} = p.unpackBinaryFixedLength(${this.size})';
  }
}

class AstOptionalType {
  late dynamic baseType;
  AstOptionalType({required this.baseType});

  String toString() => 'AstOptionalType - ${baseType}';
  sanitize() {}

  getDecl() {
    sanitize();
    return (baseType.getDecl() + '?');
  }

  packMethod(namestr) {
    var baseMethod = baseType.packMethod(namestr) as String;
    if (baseType is AstPrimitiveType) {
      baseMethod = baseMethod.replaceAll('(', 'Optional(');
      return ('${baseMethod}');
    }
    if (baseType is AstByteDataType) {
      baseMethod = baseMethod.replaceAll('(', 'Optional(');
      return ('${baseMethod}');
    }
    if (baseType is AstListType) {
      var codeStmt = '''
       if (${namestr} == null) {
         p.packNull();
       } else { 
        p.packNonNull();
        ${baseMethod}
       }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}!.');
      return codeStmt;
    }
    if (baseType is AstMapType) {
      var codeStmt = '''
       if (${namestr} == null) {
         p.packNull();
       } else { 
        p.packNonNull();
        ${baseMethod}
       }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}!.');
      return codeStmt;
    }
    if (baseType is AstUserDefinedType) {
      var codeStmt = '''
       if (${namestr} == null) {
         p.packNull();
       } else { 
        p.packNonNull();
        ${baseMethod};
       }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}!.');
      return codeStmt;
    }
    if (baseType is AstStruct) {
      var codeStmt = '''
       if (${namestr} == null) {
         p.packNull();
       } else { 
        p.packNonNull();
        ${baseMethod};
       }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}!.');
      return codeStmt;
    }
    if (baseType is AstUnion) {
      var codeStmt = '''
       if (${namestr} == null) {
         p.packNull();
       } else { 
        p.packNonNull();
        ${baseMethod};
       }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}!.');
      return codeStmt;
    }
  }

  unpackMethod(namestr) {
    var baseMethod = baseType.unpackMethod(namestr) as String;
    if (baseType is AstPrimitiveType) {
      baseMethod = baseMethod.replaceAll('(', 'Optional(');
      return ('${baseMethod}');
    }
    if (baseType is AstByteDataType) {
      baseMethod = baseMethod.replaceAll('(', 'Optional(');
      return ('${baseMethod}');
    }
    if (baseType is AstListType) {
      var codeStmt = '''
          ${baseType.getDecl()}? ${namestr}  ;
          if (p.unpackNull()) {
            ${namestr} = null;
          } else { 
            ${baseMethod}
          }
      ''';
      //codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}?.');
      return (codeStmt);
    }
    if (baseType is AstMapType) {
      var codeStmt = '''
          ${baseType.getDecl()}? ${namestr}  ;
          if (p.unpackNull()) {
            ${namestr} = null;
          } else { 
            ${baseMethod}
          }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}?.');
      return (codeStmt);
    }
    if (baseType is AstUserDefinedType) {
      var codeStmt = '''
          ${baseType.getDecl()}? ${namestr}  ;
          if (p.unpackNull()) {
            ${namestr} = null;
          } else { 
            ${baseMethod};
          }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}?.');
      return (codeStmt);
    }
    if (baseType is AstStruct) {
      var codeStmt = '''
          ${baseType.getDecl()}? ${namestr}  ;
          if (p.unpackNull()) {
            ${namestr} = null;
          } else { 
            ${baseMethod};
          }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}?.');
      return (codeStmt);
    }
    if (baseType is AstUnion) {
      var codeStmt = '''
          ${baseType.getDecl()}? ${namestr}  ;
          if (p.unpackNull()) {
            ${namestr} = null;
          } else { 
            ${baseMethod};
          }
      ''';
      codeStmt = codeStmt.replaceAll('${namestr}.', '${namestr}?.');
      return (codeStmt);
    }
  }
}

class AstListType {
  late dynamic baseType;
  int? size;
  AstListType({required this.baseType, this.size});

  String toString() => 'AstListType - ${baseType}';
  sanitize() {}

  getDecl() {
    sanitize();
    return ('List<' + baseType.getDecl() + '>');
  }

  packMethod(namestr) {
    final basepackStr = baseType.packMethod('e');
    if (size == null) {
      return ('''
        p.packLength(${namestr}.length);
        ${namestr}.forEach((e) => ${basepackStr});
      ''');
    } else {
      return ('''
          if (${namestr}.length != ${size}) { throw '${namestr} must be fixed length list of size ${size}'};
          ${namestr}.forEach((e) => ${basepackStr});
      ''');
    }
  }

  unpackMethod(namestr) {
    final typeName = baseType.getDecl();
    var baseunpackStr = baseType.unpackMethod('e') as String;

    /* Ugly hack */
    if (!(baseunpackStr.startsWith("final"))) {
      baseunpackStr = 'final ' + baseunpackStr;
    }

    if (size == null) {
      return ('''
         ${namestr} = <${typeName}>[];
        final ${namestr}Length = p.unpackLength();
        for (var i = 0; i < ${namestr}Length; i++) {
          ${baseunpackStr};
          ${namestr}.add(e);
        }
    ''');
    } else {
      return ('''
        ${namestr} = <${typeName}>[];
        for (var i = 0; i < ${size}; i++) {
          ${baseunpackStr};
          ${namestr}.add(e);
        }
      ''');
    }
  }
}

class AstMapType {
  late dynamic keyType;
  late dynamic valueType;
  AstMapType({required this.keyType, required this.valueType});

  String toString() => 'AstMapType - <${keyType}, ${valueType}>';
  sanitize() {}

  getDecl() {
    sanitize();
    return ('Map<' + keyType.getDecl() + ',' + valueType.getDecl() + '>');
  }

  packMethod(namestr) {
    final keypackStr = keyType.packMethod('k');
    final valuepackStr = valueType.packMethod('v');
    return ('''
    p.packLength(${namestr}.length);
    ${namestr}.forEach((k, v){ ${keypackStr}; ${valuepackStr};});
    ''');
  }

  unpackMethod(namestr) {
    final keytypeName = keyType.getDecl();
    final valuetypeName = valueType.getDecl();
    final keyunpackStr = keyType.unpackMethod('k');
    final valueunpackStr = valueType.unpackMethod('v');

    return ('''
      List<MapEntry<${keytypeName}, ${valuetypeName}>> entries = [];
      final ${namestr}Length = p.unpackLength();
      for (var i = 0; i < ${namestr}Length; i++) {
        ${keyunpackStr};
        ${valueunpackStr};
        entries.add(MapEntry(k,v));
      }
      final _map1 = <${keytypeName}, ${valuetypeName}>{};
      _map1.addEntries(entries);
      ${namestr} = _map1;
    ''');
  }
}

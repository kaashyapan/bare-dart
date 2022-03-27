import 'package:bare_codegen/src/class_generator/grammar.dart';
import 'package:bare_codegen/src/class_generator/model_from_ast.dart';
import 'package:bare_codegen/src/class_generator/method_from_ast.dart';
import 'package:intl/intl.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:bare_codegen/src/class_generator/anonymous.dart';

List<dynamic> makeAst(schema) {
  List<dynamic> recs = List.empty();
  AnonymousCounter().reset();

  final grammar = BareGrammarDefinition();
  final directives = grammar.build(start: grammar.start);
  final resp = directives.parse(stripComments(schema));
  recs = List<dynamic>.from(resp.value);
  return recs;
}

String stripComments(str) {
  final newString = str.replaceAllMapped(RegExp(r'(#.+\n)'), (match) {
    return '\n';
  });
  return newString;
}

String makeModelsFromAst(AssetId methodsId, List<dynamic> ast) {
  final date = DateFormat('E, MMM dd, y hh:mm a').format(DateTime.now());
  var buffer = StringBuffer();
  final meta_import =
      Config.s().immutable ? "import 'package:meta/meta.dart';" : '';
  final content = '''
        /////////////////////////////////////////////////////////////////
        // Generated code by bare_codegen - ${date} //
        /////////////////////////////////////////////////////////////////

        import 'package:bare/bare.dart';
        import 'package:fixnum/fixnum.dart';
        import 'dart:typed_data';
        ${meta_import}
        part '${methodsId.pathSegments.last}';

    ''';

  buffer.writeln(content);
  ast.forEach((element) {
    final str = makeModelFromAst(element);
    buffer.writeln(str);
  });
  return buffer.toString();
}

String makeMethodsFromAst(AssetId modelId, List<dynamic> ast) {
  final date = DateFormat('E, MMM dd, y hh:mm a').format(DateTime.now());
  var buffer = StringBuffer();

  final content = '''
        /////////////////////////////////////////////////////////////////
        // Generated code by bare_codegen - ${date} //
        /////////////////////////////////////////////////////////////////

        part of '${modelId.pathSegments.last}';

    ''';
  buffer.writeln(content);
  ast.forEach((element) {
    final str = makeMethodFromAst(element);
    buffer.writeln(str);
  });

  return buffer.toString();
}

String makeAnonymousModelsFromAst() {
  var buffer = StringBuffer();
  AnonymousCounter().sanitize();
  AnonymousCounter().structs.forEach((element) {
    final str = makeModelFromAst(element);
    buffer.writeln(str);
  });
  return buffer.toString();
}

String makeAnonymousMethodsFromAst() {
  var buffer = StringBuffer();
  AnonymousCounter().sanitize();
  AnonymousCounter().structs.forEach((element) {
    final str = makeMethodFromAst(element);
    buffer.writeln(str);
  });
  return buffer.toString();
}

String formatCode(String srcCode) {
  //final _srcCode = SourceCode(srcCode);
  final formatter = DartFormatter();
  return formatter.format(srcCode);
}

import 'package:bare_codegen/src/class_generator/ast.dart';

String makeModelFromAst(ast) {
  var buffer = StringBuffer();
  if (ast is AstEnum) {
    buffer.writeln(ast.toModel());
  }
  if (ast is AstStruct) {
    buffer.writeln(ast.toModel());
  }
  if (ast is AstUserClass) {
    buffer.writeln(ast.toModel());
  }
  if (ast is AstUnion) {
    buffer.writeln(ast.toModel());
  }

  return buffer.toString();
}

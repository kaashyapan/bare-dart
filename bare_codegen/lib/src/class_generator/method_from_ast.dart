import 'package:bare_codegen/src/class_generator/ast.dart';

String makeMethodFromAst(ast) {
  var buffer = StringBuffer();
  if (ast is AstEnum) {
    buffer.writeln(ast.toMethod());
  }

  if (ast is AstStruct) {
    buffer.writeln(ast.toMethod());
  }

  if (ast is AstUserClass) {
    buffer.writeln(ast.toMethod());
  }
  if (ast is AstUnion) {
    buffer.writeln(ast.toMethod());
  }

  return buffer.toString();
}

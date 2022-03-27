import 'package:petitparser/petitparser.dart';
import 'package:bare_codegen/src/class_generator/ast.dart';

/// Dart grammar definition.
class BareGrammarDefinition extends GrammarDefinition {
  Parser token(Object input) {
    if (input is Parser) {
      return input.token().trim(ref0(hiddenStuffWhitespace));
    } else if (input is String) {
      return token(input.toParser());
    }
    throw ArgumentError.value(input, 'Invalid token parser');
  }

  Parser unionToken() => ref1(token, 'union').flatten();
  Parser enumToken() => ref1(token, 'enum').flatten();
  Parser typeToken() => ref1(token, 'type').flatten();
  Parser structToken() => ref1(token, 'struct').flatten();
  Parser strToken() => ref1(token, 'str');
  Parser uintToken() => ref1(token, 'uint');
  Parser u8Token() => ref1(token, 'u8');
  Parser u16Token() => ref1(token, 'u16');
  Parser u32Token() => ref1(token, 'u32');
  Parser u64Token() => ref1(token, 'u64');
  Parser intToken() => ref1(token, 'int');
  Parser i8Token() => ref1(token, 'i8');
  Parser i16Token() => ref1(token, 'i16');
  Parser i32Token() => ref1(token, 'i32');
  Parser i64Token() => ref1(token, 'i64');
  Parser f32Token() => ref1(token, 'f32');
  Parser f64Token() => ref1(token, 'f64');
  Parser nullToken() => ref1(token, 'null');
  Parser boolToken() => ref1(token, 'bool');
  Parser voidToken() => ref1(token, 'void').flatten().trim();

  // Pseudo-keywords that should also be valid identifiers.
  Parser optionalToken() => ref1(token, 'optional');
  Parser baseTypeToken() => (ref0(strToken) |
          ref0(boolToken) |
          ref0(uintToken) |
          ref0(u8Token) |
          ref0(u16Token) |
          ref0(u32Token) |
          ref0(u64Token) |
          ref0(intToken) |
          ref0(i8Token) |
          ref0(i16Token) |
          ref0(i32Token) |
          ref0(i64Token) |
          ref0(f32Token) |
          ref0(f64Token))
      .flatten()
      .trim()
      .map((e) => AstPrimitiveType(name: e));

  Parser userTypeIdToken() =>
      (pattern('A-Z') & [letter(), digit()].toChoiceParser().star())
          .trim()
          .flatten()
          .map((e) => e);

  Parser enumValueNameToken() => (pattern('A-Z') &
          [pattern('A-Z'), digit(), char('_')].toChoiceParser().star())
      .trim()
      .flatten();

  Parser integer() => digit() & digit().star().flatten();

  Parser byteDataTypeToken() =>
      (ref1(token, 'data[') & (digit().star()).flatten() & ref1(token, ']'))
          .map((v) => AstByteDataType(size: int.tryParse(v[1]))) |
      (ref1(token, 'data').flatten().map((_v) => AstByteDataType(size: null)));

  Parser userTypeToken() =>
      (ref0(typeToken) & ref0(userTypeIdToken) & ref0(userTypeTypeToken))
          .map((v) {
        return AstUserClass(name: v[1], type_: v[2]);
      });

  Parser userTypeTypeToken() => ref0(nonEnumDataTypeToken);

  Parser nonVoidTypeToken() => ref0(nonEnumDataTypeToken);

  Parser voidTypeToken() => ref0(voidToken).map((e) {
        return AstVoidType();
      });
  Parser anyTypeToken() => ref0(voidTypeToken) | ref0(nonVoidTypeToken);

  Parser dataTypeToken() => ref0(baseTypeToken) | ref0(byteDataTypeToken);

  Parser optionalDataTypeToken() =>
      (ref1(token, 'optional<') & ref0(nonEnumDataTypeToken) & ref1(token, '>'))
          .map((v) => AstOptionalType(baseType: v[1]));

  Parser nonEnumDataTypeToken() =>
      ref0(aggregateDataTypeToken) |
      ref0(dataTypeToken) |
      ref0(voidTypeToken) |
      (ref0(identifier).flatten().trim().map((v) {
        return AstUserDefinedType(name: v);
      }));

  Parser aggregateDataTypeToken() =>
      ref0(optionalDataTypeToken) |
      ref0(listTypeToken) |
      ref0(mapTypeToken) |
      (ref1(token, '<') & ref0(unionBodyToken) & ref1(token, '>'))
          .map((v) => v[1] as AstUnion) |
      ref0(unionBodyToken) |
      (ref1(token, '<') & ref0(structBodyToken) & ref1(token, '>'))
          .map((v) => v[1] as AstStruct) |
      ref0(structBodyToken);

  Parser listTypeToken() =>
      ((ref1(token, 'list<') & ref0(nonEnumDataTypeToken) & ref1(token, '>')) &
              (ref1(token, '[') &
                  (digit().star()).optional() &
                  ref1(token, ']')))
          .map((v) => AstListType(baseType: v[1])) |
      ((ref1(token, 'list<') & ref0(nonEnumDataTypeToken) & ref1(token, '>')) &
              (ref1(token, '[') &
                  (whitespace().star()).optional() &
                  ref1(token, ']')))
          .map((v) => AstListType(baseType: v[1])) |
      (ref1(token, 'list<') & ref0(nonEnumDataTypeToken) & ref1(token, '>'))
          .map((v) => AstListType(baseType: v[1]));

  Parser mapTypeToken() => (ref1(token, 'map<') &
          ref0(mapKeyToken) &
          ref1(token, '><') &
          ref0(nonVoidTypeToken) &
          ref1(token, '>'))
      .map((v) => AstMapType(keyType: v[1], valueType: v[3]));

  Parser mapKeyToken() =>
      ref0(baseTypeToken) | ref0(enumDataTypeToken) | ref0(userTypeIdToken);

  Parser structMemberDefinition() => (ref0(identifier).flatten() &
              ref1(token, ':').flatten() &
              ref0(nonVoidTypeToken))
          .map((v) {
        return AstStructMember(name: v[0], type_: v[2]);
      });

  Parser unionMemberDefinition() => (((ref0(userTypeIdToken).flatten() &
                      ref1(token, '=').flatten() &
                      digit().star().flatten().trim())
                  .map((v) =>
                      AstUnionMember(name: v[0], idx: int.tryParse(v[2]))) |
              ref0(userTypeIdToken)
                  .flatten()
                  .map((v) => AstUnionMember(name: v, idx: null))) &
          ref1(token, '|').optional().flatten())
      .map((v) => v[0]);

  Parser enumMemberDefinition() =>
      (ref0(enumValueNameToken).flatten().trim() &
              ref1(token, '=').flatten().trim() &
              digit().star().flatten().trim())
          .map((v) => AstEnumMember(name: v[0], idx: int.tryParse(v[2]))) |
      ref0(enumValueNameToken)
          .flatten()
          .trim()
          .map((v) => AstEnumMember(name: v, idx: null));

  Parser enumDataTypeToken() => (ref0(typeToken).flatten() &
              ref0(identifier).flatten().trim() &
              ref0(enumToken).flatten().trim() &
              ref1(token, '{').flatten().trim() &
              ref0(enumMemberDefinition).star() &
              ref1(token, '}').flatten().trim())
          .map((v) {
        return AstEnum(name: v[1], fields: List<AstEnumMember>.from(v[4]));
      });

  Parser unionTypeToken() => (ref0(typeToken).flatten() &
              ref0(identifier).flatten().trim() &
              ref0(unionBodyToken))
          .map((v) {
        final unionBody = v[2] as AstUnion;
        unionBody.name = v[1];
        return unionBody;
      });

  Parser unionBodyToken() => (ref0(unionToken).flatten().trim() &
              ref1(token, '{').flatten().trim() &
              ref0(unionMemberDefinition).star() &
              ref1(token, '}').flatten().trim())
          .map((v) {
        return AstUnion(name: 'anon', fields: List<AstUnionMember>.from(v[2]));
      });

  Parser structTypeToken() => (ref0(typeToken).flatten().trim() &
              ref0(identifier).flatten().trim() &
              ref0(structBodyToken))
          .map((v) {
        final structBody = v[2] as AstStruct;
        structBody.name = v[1];
        return structBody;
      });

  Parser structBodyToken() => (ref0(structToken).flatten() &
              ref1(token, '{').flatten() &
              ref0(structMemberDefinition).star() &
              ref1(token, '}'))
          .map((v) {
        return AstStruct(
            name: "anon", fields: List<AstStructMember>.from(v[2]));
      });

  // -----------------------------------------------------------------
  // Grammar productions.
  // -----------------------------------------------------------------
  @override
  Parser start() => ref0(compilationUnit).end();

  Parser compilationUnit() => ref0(topLevelDefinition).star();

  Parser topLevelDefinition() =>
      ref0(structTypeToken) |
      ref0(enumDataTypeToken) |
      ref0(unionTypeToken) |
      ref0(userTypeToken) |
      ref0(newlineLexicalToken);

  Parser identifier() => ref1(token, ref0(identifierLexicalToken));
  // -----------------------------------------------------------------
  // Lexical tokens.
  // -----------------------------------------------------------------
  Parser identifierLexicalToken() =>
      ref0(identifierStartLexicalToken) &
      ref0(identifierPartLexicalToken).star();

  Parser identifierStartLexicalToken() =>
      ref0(identifierStartNoDollarLexicalToken) | char('\$');

  Parser identifierStartNoDollarLexicalToken() =>
      ref0(letterLexicalToken) | char('_');

  Parser identifierPartLexicalToken() =>
      ref0(identifierStartLexicalToken) | ref0(digitLexicalToken);

  Parser letterLexicalToken() => letter();

  Parser digitLexicalToken() => digit();

  Parser newlineLexicalToken() => pattern('\n\r');

  // -----------------------------------------------------------------
  // Whitespace and comments.
  // -----------------------------------------------------------------
  Parser hiddenWhitespace() => ref0(hiddenStuffWhitespace).plus();

  Parser hiddenStuffWhitespace() =>
      ref0(visibleWhitespace) | ref0(singleLineComment);

  Parser visibleWhitespace() => whitespace();

  Parser singleLineComment() =>
      string('#') &
      ref0(newlineLexicalToken).neg().star() &
      ref0(newlineLexicalToken).optional();
}

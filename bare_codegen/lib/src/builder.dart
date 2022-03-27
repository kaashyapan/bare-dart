import 'package:bare_codegen/src/class_generator/anonymous.dart';
import 'package:build/build.dart';
import 'dart:async';
import 'package:bare_codegen/src/class_generator/class_generator.dart';

class BareGenerator implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.bare': ['.dart', '.bare.dart']
      };

  final BuilderOptions builderOptions;

  const BareGenerator(this.builderOptions);

  @override
  Future<void> build(BuildStep buildStep) async {
    print(builderOptions.config);
    AssetId inputId = buildStep.inputId;
    final _ = Config(this.builderOptions.config);
    final modelAssetId = inputId.changeExtension('.dart');
    final partfileAssetId = inputId.changeExtension('.bare.dart');
    final schemaContents = await buildStep.readAsString(inputId);
    final ast = makeAst(schemaContents);
    final models = makeModelsFromAst(partfileAssetId, ast);
    final methods = makeMethodsFromAst(modelAssetId, ast);
    final anon_models = makeAnonymousModelsFromAst();
    final anon_methods = makeAnonymousMethodsFromAst();
    //print(methods + anon_methods);
    // Write out the new asset
    await buildStep.writeAsString(
        modelAssetId, formatCode(models + anon_models));
    await buildStep.writeAsString(
        partfileAssetId, formatCode(methods + anon_methods));
  }
}

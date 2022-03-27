library bare_codegen;

import 'package:build/build.dart';
import 'package:bare_codegen/src/builder.dart';

Builder bareGenerator(BuilderOptions options) => BareGenerator(options);

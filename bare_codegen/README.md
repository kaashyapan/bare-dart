# BARE Code generator

The code generator transforms all *.bare files into 
- *.dart
- *.bare.dart

It produces the necessary classes and the extension methods.

After running the code generator with 
```bash
  $ dart run build_runner build
```


To encode a class
```
<class_name>.toBare
```

To decode to a class
```
<class_name>.fromBare(bytes)
```

See the example folder for a sample of a schema file and the generated code.
## Code generator config options:
`to_string` - Generate `toString` override for the generated classes. `Default - True` 
```yaml
targets:
  $default:
    builders:
      bare_codegen|bareGenerator:
        options:
          to_string: True
```
## To run the project:

- Update your dependencies:

  ```bash
  $ cd bare && pub get
  $ cd bare_codegen && pub get
  $ cd example && pub get
  ```

- `cd` into `example` and run build process and run tests:

  ```bash
  $ dart run build_runner build
  $ dart test
  ```


# BARE
### (Binary Application Record Encoding)
A BARE library for Dart developers.
BARE is a simple binary representation for structured application data. [https://baremessages.org/](https://baremessages.org/)
It is an alternative to protobuf, msgpack, JSON, BSON ....
This repo provides an encoding/decoding | serialization/deserialization package for the Binary Application Record Encoding.

# About BARE

BARE is a messaging protocol optimized for small messages and simplicity of implementation. It's lightweight protocol let's you build well defined schemata and with optional code generation you'll gain compatibility and type safety over a broad range of programming environments. BARE also puts an emphasis on backwards compatibility of messages, messages encoded today will be decodable tomorrow without sacrificing extensibility.
Thus far there exist implementations for Lisp, D, .NET, Elm, Erlang, Go, Java, Javascript, OCaml, PHP, Python, Ruby, Rust and many more.

# Why choose BARE messaging

Amongst the myriad of messaging protocols there are a few with wide adoption that became de-facto standards to choose from. The choice between Google protobuf, JSON, BSON, MessagePack and so forth is a choice between tradeoffs. JSON is human and machine readable, yet the messages are pretty bulky. Protobuf optimizes against that, yet is too fragile and more complicated. BSON has MongoDB implementation details leaked into the specifications... The list goes on and on. If you like to read a more detailed report of all the trade-offs considered, please indulge in the original blog post by the BARE creator Drew DeVault: [Introducing the BARE messaging encoding](https://drewdevault.com/2020/06/21/BARE-message-encoding.html)

BARE is for you, if you want to optimize for:

- Small messages
- Standardization
- Ease of implementation
- Universal implementability with little to no need for extensions
- Simplicity — no extra junk that isn’t contributing to the core mission

# bare.dart features
The dart implemenation of BARE messaging fully supports the BARE's IETF internet-draft:[draft-devault-bare-03](https://datatracker.ietf.org/doc/draft-devault-bare/)

- Optimized for small messages: binary, not self-describing, no alignment or padding
- Standardized & simple: the specification is just over 1,000 words
- Universal: extensibility does not require expanding the implementation nor making messages which are incompatible with older implementations
  Zero dependencies
- Parsing of BARE-schemata
- Code generation of types and encoding/decoding methods of BARE-schemata.
- supports deeply nested anonymous structs and unions.

For a deeper understanding of the BARE basics, please refer to the official documentation.

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

### Sample BARE schema

```
type PublicKey data[128]
type Time str # ISO 8601

type Department enum {
  ACCOUNTING
  ADMINISTRATION
  CUSTOMER_SERVICE
  DEVELOPMENT

  # Reserved for the CEO
  JSMITH = 99
}

type Customer struct {
  name: str
  email: str
  address: Address
  orders: list<struct {
    orderId: i64
    quantity: i32
  }>
  metadata: map<str><data>
}

```

## Generated class 
(See the whole file in the examples folder)

```dart
class Customer {
  String name;
  String email;
  Address address;
  List<Orders1> orders;
  Map<String, List<int>> metadata;
  Customer(
      {required this.name,
      required this.email,
      required this.address,
      required this.orders,
      required this.metadata});

  static Customer fromBare(data) => CustomerBare.fromBare(data);

  @override
  String toString() =>
      'Customer { name: ${name}, email: ${email}, address: ${address}, orders: ${orders}, metadata: ${metadata} }';
}

extension CustomerBare on Customer {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Customer fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(name);
    p.packString(email);
    address.pack(p);
    p.packLength(orders.length);
    orders.forEach((e) => e.pack(p));

    p.packLength(metadata.length);
    metadata.forEach((k, v) {
      p.packString(k);
      p.packBinary(v);
    });

    return p;
  }

  static Customer unpack(Unpacker p) {
    final name = p.unpackString();
    final email = p.unpackString();
    Address address;
    address = AddressBare.unpack(p);

    List<Orders1> orders;
    orders = <Orders1>[];
    final ordersLength = p.unpackLength();
    for (var i = 0; i < ordersLength; i++) {
      final e = Anon1Bare.unpack(p);
      orders.add(e);
    }

    Map<String, List<int>> metadata;
    List<MapEntry<String, List<int>>> entries = [];
    final metadataLength = p.unpackLength();
    for (var i = 0; i < metadataLength; i++) {
      final k = p.unpackString();
      final v = p.unpackBinary();
      entries.add(MapEntry(k, v));
    }
    final _map1 = <String, List<int>>{};
    _map1.addEntries(entries);
    metadata = _map1;

    return Customer(
        name: name,
        email: email,
        address: address,
        orders: orders,
        metadata: metadata);
  }
}
```
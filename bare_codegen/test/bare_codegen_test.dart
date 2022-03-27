import 'package:test/test.dart';
import 'package:bare_codegen/src/class_generator/class_generator.dart';

void main() {
  test('Struct type  -> ', () {
    final schema = '''
      type Department enum {
        ACCOUNTING
        ADMINISTRATION
        CUSTOMER_SERVICE
        DEVELOPMENT

        # Reserved for the CEO
        JSMITH = 99
      }

      type Person union {Customer | Employee | TerminatedEmployee}

      type Employee struct {
        name: str
        email: str
        address: Address
        department: Department
        hireDate: Time
        publicKey: optional<PublicKey>
        metadata: map<str><data>
      }
      type Customer struct {
        orders: list<struct {
          orderId: str
          quantity: str
        }>
      }
    ''';
    final x = makeAst(schema);
    expect(x.length, 4);
  });

  test('Void type  -> ', () {
    final schema = '''
      type TerminatedEmployee void
      type TerminatedEmployee str
      type TerminatedEmployee list<str>
      type TerminatedEmployee list<i32>[]
      type TerminatedEmployee list<i32>[43]
      type TerminatedEmployee list<struct {
          orderId: str
          quantity: str
        }>
      type TerminatedEmployee map<str><str>
      type TerminatedEmployee map<str><list<struct {
          orderId: str
          quantity: str
        }>>
      type TerminatedEmployee Time
    ''';
    final x = makeAst(schema);
    expect(x.length, 9);
  });
}

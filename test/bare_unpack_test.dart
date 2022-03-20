/*
 * Package : Bare
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 31/03/2017
 * Copyright :  S.Hamblett
 */
import 'package:bare/bare.dart';
import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';
import 'package:typed_data/typed_data.dart';

void main() {
  // Common
  group('Decode Boolean -> ', () {
    test('true -> ', () {
      final x = Packer();
      x.packBool(true);
      final y = Unpacker.fromList(x.takeBytes());
      expect(y.unpackBool(), true);
    });
    test('false -> ', () {
      final x = Packer();
      x.packBool(false);
      final y = Unpacker.fromList(x.takeBytes());
      expect(y.unpackBool(), false);
    });
    test('Optional true -> ', () {
      final x = Packer();
      x.packBoolOptional(true);
      final y = Unpacker.fromList(x.takeBytes());
      expect(y.unpackBoolOptional(), true);
    });
    test('Optional false -> ', () {
      final x = Packer();
      x.packBoolOptional(false);
      final y = Unpacker.fromList(x.takeBytes());
      expect(y.unpackBoolOptional(), false);
    });
    test('Optional null -> ', () {
      final x = Packer();
      x.packBoolOptional(null);
      final y = Unpacker.fromList(x.takeBytes());
      expect(y.unpackBoolOptional(), null);
    });
  });

  group('Encode String -> ', () {
    test('utf8 -> ', () {
      final x = Packer();
      x.packString('None');
      final y = Unpacker.fromList(x.takeBytes()).unpackString();
      expect(y, 'None');
    });
    test('utf8 -> ', () {
      final x = Packer();
      x.packStringOptional('None');
      final y = Unpacker.fromList(x.takeBytes()).unpackStringOptional();
      expect(y, 'None');
    });
    test('utf8 -> ', () {
      final x = Packer();
      x.packStringOptional(null);
      final y = Unpacker.fromList(x.takeBytes()).unpackStringOptional();
      expect(y, null);
    });
  });

  group('Uint64 -> ', () {
    test('Uint64', () {
      final x = Packer();
      x.packUint64Optional(Int64(192));
      final y = Unpacker.fromList(x.takeBytes()).unpackUint64Optional();
      expect(y, Int64(192));
    });
    test('Uint64', () {
      final x = Packer();
      x.packUint64Optional(Int64(192));
      final y = Unpacker.fromList(x.takeBytes()).unpackUint64Optional();
      expect(y, Int64(192));
    });
  });
  group('Int64 -> ', () {
    test('Int64', () {
      final x = Packer();
      x.packInt64Optional(Int64(192));
      final y = Unpacker.fromList(x.takeBytes()).unpackInt64Optional();
      expect(y, Int64(192));
    });
    test('I64 negative', () {
      final x = Packer();
      x.packInt64Optional(Int64(-192));
      final y = Unpacker.fromList(x.takeBytes()).unpackInt64Optional();
      expect(y, Int64(-192));
    });
  });
  group('Int -> ', () {
    test('Int', () {
      final x = Packer();
      x.packIntOptional(Int64(192));
      final y = Unpacker.fromList(x.takeBytes()).unpackIntOptional();
      expect(y, Int64(192));
    });
    test('Int negative', () {
      final x = Packer();
      x.packIntOptional(Int64(-192));
      final y = Unpacker.fromList(x.takeBytes()).unpackIntOptional();
      expect(y, Int64(-192));
    });
  });
  group('Int32 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packInt32Optional(1994);
      final y = Unpacker.fromList(x.takeBytes()).unpackInt32Optional();
      expect(y, 1994);
    });
    test('Negative', () {
      final x = Packer();
      x.packInt32Optional(-1994);
      final y = Unpacker.fromList(x.takeBytes()).unpackInt32Optional();
      expect(y, -1994);
    });
  });

  group('Uint32 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint32Optional(192);
      final y = Unpacker.fromList(x.takeBytes()).unpackUint32Optional();
      expect(y, 192);
    });
    test('Negative', () {
      final x = Packer();
      x.packUint32(192);
      final y = Unpacker.fromList(x.takeBytes()).unpackUint32();
      expect(y, 192);
    });
  });

  group('Int16 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packInt16Optional(192);
      final y = Unpacker.fromList(x.takeBytes()).unpackInt16Optional();
      expect(y, 192);
    });
    test('Negative', () {
      final x = Packer();
      x.packInt16Optional(-192);
      final y = Unpacker.fromList(x.takeBytes()).unpackInt16Optional();
      expect(y, -192);
    });
  });

  group('Uint16 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint16Optional(192);
      final y = Unpacker.fromList(x.takeBytes()).unpackUint16Optional();
      expect(y, 192);
    });
    test('Negative', () {
      final x = Packer();
      x.packUint16Optional(192);
      final y = Unpacker.fromList(x.takeBytes()).unpackUint16Optional();
      expect(y, 192);
    });
  });
  group('Int8 -> ', () {
    test('Negative', () {
      final x = Packer();
      x.packInt8Optional(19);
      final y = Unpacker.fromList(x.takeBytes()).unpackInt8Optional();
      expect(y, 19);
    });
  });

  group('Uint8 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint8Optional(192);
      final y = Unpacker.fromList(x.takeBytes()).unpackUint8Optional();
      expect(y, 192);
    });
  });

  group('Float -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packFloatOptional(192.868);
      final y = Unpacker.fromList(x.takeBytes()).unpackFloatOptional();
      expect(y?.toStringAsExponential(3), 192.868.toStringAsExponential(3));
    });
    test('Negative', () {
      final x = Packer();
      x.packFloatOptional(-192.868);
      final y = Unpacker.fromList(x.takeBytes()).unpackFloatOptional();
      expect(y?.toStringAsExponential(3), (-192.868).toStringAsExponential(3));
    });
  });

  group('Double -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packDoubleOptional(192.868);
      final y = Unpacker.fromList(x.takeBytes()).unpackDoubleOptional();
      expect(y?.toStringAsExponential(3), 192.868.toStringAsExponential(3));
    });
    test('Negative', () {
      final x = Packer();
      x.packDoubleOptional(-192.868);
      final y = Unpacker.fromList(x.takeBytes()).unpackDoubleOptional();
      expect(y?.toStringAsExponential(3), (-192.868).toStringAsExponential(3));
    });
  });

  group('List & Map -> ', () {
    test('List', () {
      final x = Packer();
      final ls = [1, 2, 3];
      x.packLength(ls.length);
      ls.forEach((e) => x.packInt32(e));

      final y = Unpacker.fromList(x.takeBytes());
      final len = y.unpackLength();
      final lst = [];
      for (var i = 0; i < len; i++) {
        lst.add(y.unpackInt32());
      }
      expect(lst, ls);
    });
    test('Map', () {
      final x = Packer();
      final map = {"a": 1, "b": 2, "c": 3};
      x.packLength(map.length);
      map.forEach((k, v) {
        x.packString(k);
        x.packInt32(v);
      });

      final y = Unpacker.fromList(x.takeBytes());
      final len = y.unpackLength();
      final map1 = {};
      for (var i = 0; i < len; i++) {
        final k = y.unpackString();
        final v = y.unpackInt32();
        map1[k] = v;
      }
      expect(map, map1);
    });
  });
}

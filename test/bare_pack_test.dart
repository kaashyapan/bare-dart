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
  group('Encode Boolean -> ', () {
    test('true -> ', () {
      final x = Packer();
      x.packBool(true);
      expect(x.takeBytes(), [1]);
    });
    test('false -> ', () {
      final x = Packer();
      x.packBool(false);
      expect(x.takeBytes(), [0]);
    });
    test('Optional true -> ', () {
      final x = Packer();
      x.packBoolOptional(true);

      expect(x.takeBytes(), [1, 1]);
    });
    test('Optional false -> ', () {
      final x = Packer();
      x.packBoolOptional(false);
      expect(x.takeBytes(), [1, 0]);
    });
    test('Optional null -> ', () {
      final x = Packer();
      x.packBoolOptional(null);
      expect(x.takeBytes(), [0]);
    });
  });

  group('Encode String -> ', () {
    test('utf8 -> ', () {
      final x = Packer();
      x.packString('None');
      expect(x.takeBytes(), [4, 78, 111, 110, 101]);
    });
    test('Optional utf8 -> ', () {
      final x = Packer();
      x.packStringOptional('None');
      expect(x.takeBytes(), [1, 4, 78, 111, 110, 101]);
    });

    test('Missing -> ', () {
      final x = Packer();
      x.packStringOptional(null);
      expect(x.takeBytes(), [0]);
    });
  });

  group('Uint64 -> ', () {
    test('Uint64', () {
      final x = Packer();
      x.packUint64(Int64(192));
      expect(x.takeBytes(), [192, 0, 0, 0, 0, 0, 0, 0]);
    });
  });
  group('Int64 -> ', () {
    test('Int64', () {
      final x = Packer();
      x.packInt64(Int64(192));
      expect(x.takeBytes(), [192, 0, 0, 0, 0, 0, 0, 0]);
    });
    test('I64 negative', () {
      final x = Packer();
      x.packInt64(Int64(-192));
      expect(x.takeBytes(), [64, 255, 255, 255, 255, 255, 255, 255]);
    });
  });
  group('Int -> ', () {
    test('Int', () {
      final x = Packer();
      x.packInt(Int64(192));
      expect(x.takeBytes(), [128, 3]);
    });
    test('Int negative', () {
      final x = Packer();
      x.packInt(Int64(-192));
      expect(x.takeBytes(), [255, 2]);
    });
  });
  group('Int32 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packInt32(1994);
      expect(x.takeBytes(), [202, 7, 0, 0]);
    });
    test('Negative', () {
      final x = Packer();
      x.packInt32(-1994);
      expect(x.takeBytes(), [54, 248, 255, 255]);
    });
  });

  group('Uint32 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint32(192);
      expect(x.takeBytes(), [192, 0, 0, 0]);
    });
    test('Negative', () {
      final x = Packer();
      x.packUint32(-192);
      expect(x.takeBytes(), [64, 255, 255, 255]);
    });
  });

  group('Int16 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packInt16(192);
      expect(x.takeBytes(), [192, 0]);
    });
    test('Negative', () {
      final x = Packer();
      x.packInt16(-192);
      expect(x.takeBytes(), [64, 255]);
    });
  });

  group('Uint16 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint16(192);
      expect(x.takeBytes(), [192, 0]);
    });
    test('Negative', () {
      final x = Packer();
      x.packUint16(-192);
      expect(x.takeBytes(), [64, 255]);
    });
  });
  group('Int8 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packInt8(192);
      expect(x.takeBytes(), [192]);
    });
    test('Negative', () {
      final x = Packer();
      x.packInt8(-192);
      expect(x.takeBytes(), [64]);
    });
  });

  group('Uint8 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint8(192);
      expect(x.takeBytes(), [192]);
    });
    test('Negative', () {
      final x = Packer();
      x.packUint8(-192);
      expect(x.takeBytes(), [64]);
    });
  });

  group('Float -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packFloat(192.868);
      expect(x.takeBytes(), [53, 222, 64, 67]);
    });
    test('Negative', () {
      final x = Packer();
      x.packFloat(-192.868);
      expect(x.takeBytes(), [53, 222, 64, 195]);
    });
  });

  group('Double -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packDouble(192.868);
      expect(x.takeBytes(), [178, 157, 239, 167, 198, 27, 104, 64]);
    });
    test('Negative', () {
      final x = Packer();
      x.packDouble(-192.868);
      expect(x.takeBytes(), [178, 157, 239, 167, 198, 27, 104, 192]);
    });
  });

  group('List & Map -> ', () {
    test('List', () {
      final x = Packer();
      final ls = [1, 2, 3];
      x.packLength(ls.length);
      ls.forEach((e) => x.packInt32(e));
      expect(x.takeBytes(), [3, 1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0]);
    });
    test('Map', () {
      final x = Packer();
      final map = {"a": 1, "b": 2, "c": 3};
      x.packLength(map.length);
      map.forEach((k, v) {
        x.packString(k);
        x.packInt32(v);
      });
      expect(x.takeBytes(),
          [3, 1, 97, 1, 0, 0, 0, 1, 98, 2, 0, 0, 0, 1, 99, 3, 0, 0, 0]);
    });
  });
}

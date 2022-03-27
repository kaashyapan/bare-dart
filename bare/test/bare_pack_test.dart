/*
 * Package : Bare
 * Author : kāśyapan <vichitraveeryan@gmail.com>
 * Date   : 20/03/2022
 * Copyright : kāśyapan
 */
import 'package:bare/bare.dart';
import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';
import 'common.dart';
import 'package:collection/collection.dart';

Function deepEq = const DeepCollectionEquality().equals;

void main() {
  // Common
  group('Encode Boolean -> ', () {
    test('true -> ', () {
      final x = Packer();
      x.packBool(true);
      expect(deepEq(x.takeBytes(), [1]), true);
    });
    test('false -> ', () {
      final x = Packer();
      x.packBool(false);
      expect(deepEq(x.takeBytes(), [0]), true);
    });
    test('Optional true -> ', () {
      final x = Packer();
      x.packBoolOptional(true);

      expect(deepEq(x.takeBytes(), [1, 1]), true);
    });
    test('Optional false -> ', () {
      final x = Packer();
      x.packBoolOptional(false);
      expect(deepEq(x.takeBytes(), [1, 0]), true);
    });
    test('Optional null -> ', () {
      final x = Packer();
      x.packBoolOptional(null);
      expect(deepEq(x.takeBytes(), [0]), true);
    });
  });

  group('Encode String -> ', () {
    test('utf8 -> ', () {
      final x = Packer();
      x.packString('None');
      expect(deepEq(x.takeBytes(), [4, 78, 111, 110, 101]), true);
    });
    test('Optional utf8 -> ', () {
      final x = Packer();
      x.packStringOptional('None');
      expect(deepEq(x.takeBytes(), [1, 4, 78, 111, 110, 101]), true);
    });

    test('Missing -> ', () {
      final x = Packer();
      x.packStringOptional(null);
      expect(deepEq(x.takeBytes(), [0]), true);
    });
  });

  group('Uint64 -> ', () {
    test('Uint64', () {
      final x = Packer();
      x.packUint64(Int64(192));
      expect(deepEq(x.takeBytes(), [192, 0, 0, 0, 0, 0, 0, 0]), true);
    });
  });
  group('Int64 -> ', () {
    test('Int64', () {
      final x = Packer();
      x.packInt64(Int64(192));
      expect(deepEq(x.takeBytes(), [192, 0, 0, 0, 0, 0, 0, 0]), true);
    });
    test('I64 negative', () {
      final x = Packer();
      x.packInt64(Int64(-192));
      expect(
          deepEq(x.takeBytes(), [64, 255, 255, 255, 255, 255, 255, 255]), true);
    });
  });
  group('Int -> ', () {
    test('Int', () {
      final x = Packer();
      x.packInt(Int64(192));
      expect(deepEq(x.takeBytes(), [128, 3]), true);
    });
    test('Int negative', () {
      final x = Packer();
      x.packInt(Int64(-192));
      expect(deepEq(x.takeBytes(), [255, 2]), true);
    });
  });
  group('Int32 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packInt32(1994);
      expect(deepEq(x.takeBytes(), [202, 7, 0, 0]), true);
    });
    test('Negative', () {
      final x = Packer();
      x.packInt32(-1994);
      expect(deepEq(x.takeBytes(), [54, 248, 255, 255]), true);
    });
  });

  group('Uint32 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint32(192);
      expect(deepEq(x.takeBytes(), [192, 0, 0, 0]), true);
    });
    test('Negative', () {
      final x = Packer();
      x.packUint32(-192);
      expect(deepEq(x.takeBytes(), [64, 255, 255, 255]), true);
    });
  });

  group('Int16 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packInt16(192);
      expect(deepEq(x.takeBytes(), [192, 0]), true);
    });
    test('Negative', () {
      final x = Packer();
      x.packInt16(-192);
      expect(deepEq(x.takeBytes(), [64, 255]), true);
    });
  });

  group('Uint16 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint16(192);
      expect(deepEq(x.takeBytes(), [192, 0]), true);
    });
    test('Negative', () {
      final x = Packer();
      x.packUint16(-192);
      expect(deepEq(x.takeBytes(), [64, 255]), true);
    });
  });
  group('Int8 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packInt8(192);
      expect(deepEq(x.takeBytes(), [192]), true);
    });
    test('Negative', () {
      final x = Packer();
      x.packInt8(-192);
      expect(deepEq(x.takeBytes(), [64]), true);
    });
  });

  group('Uint8 -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packUint8(192);
      expect(deepEq(x.takeBytes(), [192]), true);
    });
    test('Negative', () {
      final x = Packer();
      x.packUint8(-192);
      expect(deepEq(x.takeBytes(), [64]), true);
    });
  });

  group('Float -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packFloat(192.868);
      expect(deepEq(x.takeBytes(), [53, 222, 64, 67]), true);
    });
    test('Negative', () {
      final x = Packer();
      x.packFloat(-192.868);
      expect(deepEq(x.takeBytes(), [53, 222, 64, 195]), true);
    });
  });

  group('Double -> ', () {
    test('Positive', () {
      final x = Packer();
      x.packDouble(192.868);
      expect(
          deepEq(x.takeBytes(), [178, 157, 239, 167, 198, 27, 104, 64]), true);
    });
    test('Negative', () {
      final x = Packer();
      x.packDouble(-192.868);
      expect(
          deepEq(x.takeBytes(), [178, 157, 239, 167, 198, 27, 104, 192]), true);
    });
  });

  group('List & Map -> ', () {
    test('List', () {
      final x = Packer();
      final ls = [1, 2, 3];
      x.packLength(ls.length);
      ls.forEach((e) => x.packInt32(e));
      expect(
          deepEq(x.takeBytes(), [3, 1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0]), true);
    });
    test('Map', () {
      final x = Packer();
      final map = {'a': 1, 'b': 2, 'c': 3};
      x.packLength(map.length);
      map.forEach((k, v) {
        x.packString(k);
        x.packInt32(v);
      });
      expect(
          deepEq(x.takeBytes(),
              [3, 1, 97, 1, 0, 0, 0, 1, 98, 2, 0, 0, 0, 1, 99, 3, 0, 0, 0]),
          true);
    });
  });
  test('Object', () {
    final p = Packer();
    final rec1 = Rec1([Rec2('a', 'b')]);
    rec1.pack(p);
    expect(deepEq(p.takeBytes(), [1, 1, 1, 97, 1, 1, 98]), true);
  });

  test('Binary', () {
    final p = Packer();
    final rec1 = [1, 1, 1, 97, 1, 1, 98];
    p.packBinary(rec1);
    final byts = p.takeBytes();
    expect(deepEq(byts, [7, 1, 1, 1, 97, 1, 1, 98]), true);
  });

  test('Binary', () {
    final p = Packer();
    final rec1 = [1, 1, 1, 97, 1, 1, 98];
    p.packBinaryOptional(rec1);
    final byts = p.takeBytes();
    expect(deepEq(byts, [1, 7, 1, 1, 1, 97, 1, 1, 98]), true);
  });

  test('Binary Fixed length', () {
    final p = Packer();
    final rec1 = [1, 1, 1, 97, 1, 1, 98];
    p.packBinaryFixedLength(7, rec1);
    final byts = p.takeBytes();
    expect(deepEq(byts, [1, 1, 1, 97, 1, 1, 98]), true);
  });

  test('Binary Fixed length', () {
    final p = Packer();
    final rec1 = [1, 1, 1, 97, 1, 1, 98];
    p.packBinaryFixedLengthOptional(7, rec1);
    final byts = p.takeBytes();
    expect(deepEq(byts, [1, 1, 1, 1, 97, 1, 1, 98]), true);
  });
  test('Binary Fixed length excpetin', () {
    try {
      final p = Packer();
      final rec1 = [1, 1, 1, 97, 1, 1, 98];
      p.packBinaryFixedLengthOptional(8, rec1);
    } catch (e) {
      if (e ==
          'Tried to encode a binary of length 7 into a fixed length binary of length 8') {
        return;
      } else {
        rethrow;
      }
    }
    throw Exception('Expected Exception');
  });
}

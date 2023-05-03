//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unit.g.dart';

/// Unit
///
/// Properties:
/// * [id] - Unit id
/// * [description] - Unit description
@BuiltValue()
abstract class Unit implements Built<Unit, UnitBuilder> {
  /// Unit id
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// Unit description
  @BuiltValueField(wireName: r'description')
  String? get description;

  Unit._();

  factory Unit([void updates(UnitBuilder b)]) = _$Unit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Unit> get serializer => _$UnitSerializer();
}

class _$UnitSerializer implements PrimitiveSerializer<Unit> {
  @override
  final Iterable<Type> types = const [Unit, _$Unit];

  @override
  final String wireName = r'Unit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Unit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Unit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnitBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Unit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnitBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}


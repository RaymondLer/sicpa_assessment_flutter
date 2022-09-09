// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchedHistoryAdapter extends TypeAdapter<SearchedHistory> {
  @override
  final int typeId = 0;

  @override
  SearchedHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchedHistory(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SearchedHistory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.searchedText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchedHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

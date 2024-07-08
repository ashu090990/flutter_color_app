// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ColorModel {
  String name;
  String hex;
  String theme;
  String group;
  String rgb;
  ColorModel({
    required this.name,
    required this.hex,
    required this.theme,
    required this.group,
    required this.rgb,
  });


  ColorModel copyWith({
    String? name,
    String? hex,
    String? theme,
    String? group,
    String? rgb,
  }) {
    return ColorModel(
      name: name ?? this.name,
      hex: hex ?? this.hex,
      theme: theme ?? this.theme,
      group: group ?? this.group,
      rgb: rgb ?? this.rgb,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'hex': hex,
      'theme': theme,
      'group': group,
      'rgb': rgb,
    };
  }

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      name: map['name'] as String,
      hex: map['hex'] as String,
      theme: map['theme'] as String,
      group: map['group'] as String,
      rgb: map['rgb'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorModel.fromJson(String source) => ColorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ColorModel(name: $name, hex: $hex, theme: $theme, group: $group, rgb: $rgb)';
  }

  @override
  bool operator ==(covariant ColorModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.hex == hex &&
      other.theme == theme &&
      other.group == group &&
      other.rgb == rgb;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      hex.hashCode ^
      theme.hashCode ^
      group.hashCode ^
      rgb.hashCode;
  }
}

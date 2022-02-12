import 'dart:convert';

import 'package:searches_clean_arch/modules/search/domain/entities/result_search_entity.dart';

// Dart Data Class Generator VSCode extension helps to create serialization
class ResultSearchModel extends ResultSearchEntity {
  ResultSearchModel({title, description, image}) : super(
    title: title,
    description: description,
    image: image,
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      title: map['title'],
      description: map['description'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) => ResultSearchModel.fromMap(json.decode(source));
}
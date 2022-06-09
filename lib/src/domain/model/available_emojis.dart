enum EmojisModel {
  redHeart,
  thumbsUp,
  fire,
  smilingFaceWithThreeHearts,
  cryingFace,
}

extension AvailableEmojisExtentions on EmojisModel {
  String get unicode {
    switch (this) {
      case EmojisModel.redHeart:
        return '\u{1F496}';
      case EmojisModel.thumbsUp:
        return '\u{1F44D}';
      case EmojisModel.fire:
        return '\u{1F525}';
      case EmojisModel.smilingFaceWithThreeHearts:
        return '\u{1F970}';
      case EmojisModel.cryingFace:
        return '\u{1F622}';
      default:
        throw UnimplementedError();
    }
  }

  static EmojisModel getFromUnicode(String unicode) {
    switch (unicode) {
      case '\u{1F496}':
        return EmojisModel.redHeart;
      case '\u{1F44D}':
        return EmojisModel.thumbsUp;
      case '\u{1F525}':
        return EmojisModel.fire;
      case '\u{1F970}':
        return EmojisModel.smilingFaceWithThreeHearts;
      case '\u{1F622}':
        return EmojisModel.cryingFace;
      default:
        throw UnimplementedError();
    }
  }
}

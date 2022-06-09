enum AvailableEmojis {
  redHeart,
  thumbsUp,
  fire,
  smilingFaceWithThreeHearts,
  cryingFace,
}

extension AvailableEmojisExtentions on AvailableEmojis {
  String get unicode {
    switch (this) {
      case AvailableEmojis.redHeart:
        return '\u{1F496}';
      case AvailableEmojis.thumbsUp:
        return '\u{1F44D}';
      case AvailableEmojis.fire:
        return '\u{1F525}';
      case AvailableEmojis.smilingFaceWithThreeHearts:
        return '\u{1F970}';
      case AvailableEmojis.cryingFace:
        return '\u{1F622}';
      default:
        throw UnimplementedError();
    }
  }

  static AvailableEmojis getFromUnicode(String unicode) {
    switch (unicode) {
      case '\u{1F496}':
        return AvailableEmojis.redHeart;
      case '\u{1F44D}':
        return AvailableEmojis.thumbsUp;
      case '\u{1F525}':
        return AvailableEmojis.fire;
      case '\u{1F970}':
        return AvailableEmojis.smilingFaceWithThreeHearts;
      case '\u{1F622}':
        return AvailableEmojis.cryingFace;
      default:
        throw UnimplementedError();
    }
  }
}

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
      case '\u{FE0F}':
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

// abstract class _AvailableEmojis {
//   static const Map<String, String> emojisMap = {
//     'redHeart': '\u{FE0F}',
//     'thumbsUp': '\u{1F44D}',
//     'fire': '\u{1F525}',
//     'smilingFaceWithThreeHearts': '\u{1F970}',
//     'cryingFace': '\u{1F622}',
//   };
//
//   static List<String> get emojiNameList => emojisMap.keys.toList();
//
//   static List<String> get emojiList => emojisMap.values.toList();
// }

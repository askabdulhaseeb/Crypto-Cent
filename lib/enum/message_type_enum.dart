enum MessageTypeEnum {
  text('text', 'Text'),
  image('image', 'Image'),
  audio('audio', 'Audio'),
  video('video', 'Video'),
  prodOffer('prod_offer', 'Product Offer'),
  prodOfferAccepted('prod_offer_accept', 'Product Offer Acepted'),
  prodOfferRejected('prod_offer_reject', 'Product Offer Rejected'),
  document('document', 'Document'),
  announcement('announcement', 'Announcement'),
  storyReply('story_reply', 'Story Reply');

  const MessageTypeEnum(this.json, this.title);
  final String json;
  final String title;
}

class MessageTypeEnumConvertor {
  static MessageTypeEnum toEnum(String type) {
    if (type == 'text') {
      return MessageTypeEnum.text;
    } else if (type == 'image') {
      return MessageTypeEnum.image;
    } else if (type == 'audio') {
      return MessageTypeEnum.audio;
    } else if (type == 'video') {
      return MessageTypeEnum.video;
    } else if (type == 'document') {
      return MessageTypeEnum.document;
    } else if (type == 'announcement') {
      return MessageTypeEnum.announcement;
    } else if (type == 'prod_offer') {
      return MessageTypeEnum.prodOffer;
    } else {
      return MessageTypeEnum.storyReply;
    }
  }
}

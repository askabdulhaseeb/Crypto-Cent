const admin = require("firebase-admin");
const functions = require("firebase-functions");

admin.initializeApp();

const messaging = admin.messaging();

// eslint-disable-next-line max-len
exports.notifySubscribers = functions.https.onCall(async (dateValue, _) => {
  try {
    await messaging.sendToDevice(data.targetDevices, {
      notification: {
        title: dateValue.messageTitle,
        body: dateValue.messageBody,
        icon: "https://freesvg.org/img/1534129544.png",
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
      data: {
        key1: dateValue.value1,
        key2: dateValue.value2,
        key3: dateValue.value3,
      },
    });
    return true;
  } catch (ex) {
    return false;
  }
});

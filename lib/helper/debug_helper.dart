import 'package:cloud_firestore/cloud_firestore.dart';

class DebugHelper {
  static const bool globalDebug = true;
  static void dataGenerator() {
    Firestore.instance
        .collection('all_diagnosis/RVzCMyr5bEeFgE2GcgziFwYcfMb2/diagnosis')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    }).then((value) {
      Firestore.instance
          .collection('all_diagnosis/RVzCMyr5bEeFgE2GcgziFwYcfMb2/diagnosis')
          .add({
        'feverExplanation':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
        'sweatExplanation':
            'Ipsum nunc aliquet bibendum enim facilisis gravida neque convallis. Sed faucibus turpis in eu. Quis viverra nibh cras pulvinar mattis. Pharetra et ultrices neque ornare. ',
        'headacheExplanation':
            'Eu turpis egestas pretium aenean pharetra magna ac placerat vestibulum. Ultrices dui sapien eget mi. Ac felis donec et odio pellentesque. Nascetur ridiculus mus mauris vitae ultricies leo integer malesuada nunc. ',
        'sleepingExplanation':
            'Pulvinar sapien et ligula ullamcorper malesuada proin. Sit amet volutpat consequat mauris.',
        'excretoryExplanation':
            'Viverra adipiscing at in tellus integer. Ut lectus arcu bibendum at.',
        'numbessExplanation': 'Ut lectus arcu bibendum at.',
        'otherExplanation':
            'Mus mauris vitae ultricies leo integer malesuada nunc vel. Sed libero enim sed faucibus turpis. Amet aliquam id diam maecenas ultricies. A cras semper auctor neque vitae tempus quam pellentesque nec. Arcu dui vivamus arcu felis. Bibendum ut tristique et egestas quis. Est ultricies integer quis auctor elit sed. Eu sem integer vitae justo eget magna fermentum iaculis eu. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Nibh mauris cursus mattis molestie a iaculis at erat.',
        'proneFeeling': 'Hot',
        'timeStamp': Timestamp.now(),
        'imageUrl':
            'https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg',
        'moreData': false,
        'address': null,
        'price': null,
        'invoiceUrl': null,
        'trackingNumber': null,
      });
      Firestore.instance
          .collection('all_diagnosis/RVzCMyr5bEeFgE2GcgziFwYcfMb2/diagnosis')
          .add({
        'feverExplanation':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
        'sweatExplanation':
            'Ipsum nunc aliquet bibendum enim facilisis gravida neque convallis. Sed faucibus turpis in eu. Quis viverra nibh cras pulvinar mattis. Pharetra et ultrices neque ornare. ',
        'headacheExplanation':
            'Eu turpis egestas pretium aenean pharetra magna ac placerat vestibulum. Ultrices dui sapien eget mi. Ac felis donec et odio pellentesque. Nascetur ridiculus mus mauris vitae ultricies leo integer malesuada nunc. ',
        'sleepingExplanation':
            'Pulvinar sapien et ligula ullamcorper malesuada proin. Sit amet volutpat consequat mauris.',
        'excretoryExplanation':
            'Viverra adipiscing at in tellus integer. Ut lectus arcu bibendum at.',
        'numbessExplanation': 'Ut lectus arcu bibendum at.',
        'otherExplanation':
            'Mus mauris vitae ultricies leo integer malesuada nunc vel. Sed libero enim sed faucibus turpis. Amet aliquam id diam maecenas ultricies. A cras semper auctor neque vitae tempus quam pellentesque nec. Arcu dui vivamus arcu felis. Bibendum ut tristique et egestas quis. Est ultricies integer quis auctor elit sed. Eu sem integer vitae justo eget magna fermentum iaculis eu. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Nibh mauris cursus mattis molestie a iaculis at erat.',
        'proneFeeling': 'Hot',
        'timeStamp': Timestamp.now(),
        'imageUrl':
            'https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg',
        'moreData': false,
        'address': null,
        'price': 400,
        'invoiceUrl': null,
        'trackingNumber': null,
      });
      Firestore.instance
          .collection('all_diagnosis/RVzCMyr5bEeFgE2GcgziFwYcfMb2/diagnosis')
          .add({
        'feverExplanation':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
        'sweatExplanation':
            'Ipsum nunc aliquet bibendum enim facilisis gravida neque convallis. Sed faucibus turpis in eu. Quis viverra nibh cras pulvinar mattis. Pharetra et ultrices neque ornare. ',
        'headacheExplanation':
            'Eu turpis egestas pretium aenean pharetra magna ac placerat vestibulum. Ultrices dui sapien eget mi. Ac felis donec et odio pellentesque. Nascetur ridiculus mus mauris vitae ultricies leo integer malesuada nunc. ',
        'sleepingExplanation':
            'Pulvinar sapien et ligula ullamcorper malesuada proin. Sit amet volutpat consequat mauris.',
        'excretoryExplanation':
            'Viverra adipiscing at in tellus integer. Ut lectus arcu bibendum at.',
        'numbessExplanation': 'Ut lectus arcu bibendum at.',
        'otherExplanation':
            'Mus mauris vitae ultricies leo integer malesuada nunc vel. Sed libero enim sed faucibus turpis. Amet aliquam id diam maecenas ultricies. A cras semper auctor neque vitae tempus quam pellentesque nec. Arcu dui vivamus arcu felis. Bibendum ut tristique et egestas quis. Est ultricies integer quis auctor elit sed. Eu sem integer vitae justo eget magna fermentum iaculis eu. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Nibh mauris cursus mattis molestie a iaculis at erat.',
        'proneFeeling': 'Hot',
        'timeStamp': Timestamp.now(),
        'imageUrl':
            'https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg',
        'moreData': false,
        'address': '219/5 asdasdasdasd s das das dsdas das d1210120',
        'price': 400,
        'invoiceUrl':
            'https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg',
        'trackingNumber': null,
      });
      Firestore.instance
          .collection('all_diagnosis/RVzCMyr5bEeFgE2GcgziFwYcfMb2/diagnosis')
          .add({
        'feverExplanation':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
        'sweatExplanation':
            'Ipsum nunc aliquet bibendum enim facilisis gravida neque convallis. Sed faucibus turpis in eu. Quis viverra nibh cras pulvinar mattis. Pharetra et ultrices neque ornare. ',
        'headacheExplanation':
            'Eu turpis egestas pretium aenean pharetra magna ac placerat vestibulum. Ultrices dui sapien eget mi. Ac felis donec et odio pellentesque. Nascetur ridiculus mus mauris vitae ultricies leo integer malesuada nunc. ',
        'sleepingExplanation':
            'Pulvinar sapien et ligula ullamcorper malesuada proin. Sit amet volutpat consequat mauris.',
        'excretoryExplanation':
            'Viverra adipiscing at in tellus integer. Ut lectus arcu bibendum at.',
        'numbessExplanation': 'Ut lectus arcu bibendum at.',
        'otherExplanation':
            'Mus mauris vitae ultricies leo integer malesuada nunc vel. Sed libero enim sed faucibus turpis. Amet aliquam id diam maecenas ultricies. A cras semper auctor neque vitae tempus quam pellentesque nec. Arcu dui vivamus arcu felis. Bibendum ut tristique et egestas quis. Est ultricies integer quis auctor elit sed. Eu sem integer vitae justo eget magna fermentum iaculis eu. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Nibh mauris cursus mattis molestie a iaculis at erat.',
        'proneFeeling': 'Hot',
        'timeStamp': Timestamp.now(),
        'imageUrl':
            'https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg',
        'moreData': false,
        'address': null,
        'price': 400,
        'invoiceUrl':
            'https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg',
        'trackingNumber': 'A2151515ASDCSDA',
      });
    });
  }
}

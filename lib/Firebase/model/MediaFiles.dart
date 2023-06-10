

import 'base/FirestoreDocument.dart';

class MediaFiles extends FirestoreDocument {
  dynamic defaultMedia;
  dynamic media; // array of {type:string,link:string}

  MediaFiles.fromSnapshot(Map<String, dynamic> snapshot,String? id)
      : defaultMedia =snapshot==null? null:snapshot['defaultMedia'],
        media = snapshot==null?null:snapshot['media'],
        super.fromSnapshot(snapshot,id);
}

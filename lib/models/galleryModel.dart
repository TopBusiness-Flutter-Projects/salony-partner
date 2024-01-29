class Gallery {
  int? vendor_id;
  int? id;
  String? image;

  Gallery();

  Map<String, dynamic> toJson() => {'vendor_id': vendor_id != null ? vendor_id : null, 'image': image != null ? image : null, 'id': id != null ? id : null};

  Gallery.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      image = json['image'] != null ? json['image'] : null;
      id = json['id'] != null ? json['id'] : null;
    } catch (e) {
      print("Exception - galleryModel.dart - Gallery.fromJson():" + e.toString());
    }
  }
}

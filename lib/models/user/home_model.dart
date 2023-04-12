class HomeModel {
  String? message;
  bool? status;
  Data? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<Stories>? stories;
  List<Advertisements>? advertisements;
  List<Categories>? categories;
  List<Products>? products;


  Data.fromJson(Map<String, dynamic> json) {
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add( Stories.fromJson(v));
      });
    }
    if (json['advertisements'] != null) {
      advertisements = <Advertisements>[];
      json['advertisements'].forEach((v) {
        advertisements!.add( Advertisements.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add( Categories.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

}

class Stories {
  String? id;
  String? storeName;
  String? providerStoryThumbnail;
  List<String>? stories;

  Stories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    providerStoryThumbnail = json['provider_story_thumbnail'];
    if(json['stories'].isNotEmpty){
      stories = json['stories'].cast<String>();
    }
  }
}

class Advertisements {
  String? id;
  String? title;
  String? description;
  String? link;
  String? backgroundImage;
  int? type;

  Advertisements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    backgroundImage = json['background_image'];
    type = json['type'];
  }

}

class Categories {
  String? id;
  String? title;
  String? image;


  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}

class Products {
  String? id;
  String? title;
  String? description;
  String? titleEn;
  String? titleAr;
  String? descriptionEn;
  String? descriptionAr;
  ProviderId? providerId;
  String? categoryId;
  int? priceBeforeDiscount;
  int? discount;
  int? priceAfterDicount;
  String? weight;
  int? quantity;
  int? totalRate;
  bool? isFavorited;
  //List<Null>? reviews;
  List<String>? images;


  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    providerId = json['provider_id'] != null
        ? new ProviderId.fromJson(json['provider_id'])
        : null;
    categoryId = json['category_id'];
    priceBeforeDiscount = json['price_before_discount'];
    discount = json['discount'];
    priceAfterDicount = json['price_after_dicount'];
    weight = json['weight'];
    quantity = json['quantity'];
    totalRate = json['total_rate'];
    isFavorited = json['is_favorited'];
    // if (json['reviews'] != null) {
    //   reviews = <Null>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Null.fromJson(v));
    //   });
    // }
    images = json['images'].cast<String>();
  }

}

class ProviderId {
  String? id;
  int? itemNumber;
  String? storeName;
  String? email;
  List<Categories>? categoryId;
  String? firebaseToken;
  String? whatsappNumber;
  String? phoneNumber;
  String? personalPhoto;
  String? currentLanguage;
  int? totalRate;
  int? status;
  String? createdAt;
  Stories? stories;



  ProviderId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    storeName = json['store_name'];
    email = json['email'];
    if (json['category_id'] != null) {
      categoryId = <Categories>[];
      json['category_id'].forEach((v) {
        categoryId!.add(Categories.fromJson(v));
      });
    }
    stories = json['stories'] != null ? Stories.fromJson(json['stories']) : null;
    firebaseToken = json['firebase_token'];
    whatsappNumber = json['whatsapp_number'];
    phoneNumber = json['phone_number'];
    personalPhoto = json['personal_photo'];
    currentLanguage = json['current_language'];
    totalRate = json['total_rate'];
    status = json['status'];
    createdAt = json['created_at'];
  }

}

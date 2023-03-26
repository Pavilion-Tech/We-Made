class StaticPageModel {
  String? message;
  bool? status;
  Data? data;

  StaticPageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? termsAndConditiondsEn;
  String? termsAndConditiondsAr;
  String? termsAndConditiondsUr;
  String? aboutUsEn;
  String? aboutUsAr;
  String? aboutUsUr;


  Data.fromJson(Map<String, dynamic> json) {
    termsAndConditiondsEn = json['terms_and_conditionds_en'];
    termsAndConditiondsAr = json['terms_and_conditionds_ar'];
    termsAndConditiondsUr = json['terms_and_conditionds_ur'];
    aboutUsEn = json['about_us_en'];
    aboutUsAr = json['about_us_ar'];
    aboutUsUr = json['about_us_ur'];
  }
}

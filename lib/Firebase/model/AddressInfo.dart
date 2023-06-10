import "referencedata/City.dart" show City;
import "referencedata/State.dart" show State;
import "country/Province.dart" show ProvinceInfo;
import "referencedata/Country.dart" show Country;

abstract class AddressInfo {
  String? /* String? | null */ street;
  City? /* City | null */ city;
  State? /* State | null */ state;
  ProvinceInfo? /* ProvinceInfo | null */ province;
  Country? /* Country | null */ country;
}

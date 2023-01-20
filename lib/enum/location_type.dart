enum LocationType {
  product('product'),
  delievery('delievery');

  const LocationType(this.json);
  final String json;
}

class LocationTypeConverter {
  LocationType toEnum(String value) {
    switch (value) {
      case 'product':
        return LocationType.product;
        default :
        return LocationType.delievery;
    }
  }
}

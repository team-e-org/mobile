enum Flavor {
  DEV,
  STAGING,
  PRODUCTION,
}

class F {
  static Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'pinko-dev';
      case Flavor.STAGING:
        return 'pinko-staging';
      case Flavor.PRODUCTION:
        return 'pinko';
      default:
        return 'title';
    }
  }

}

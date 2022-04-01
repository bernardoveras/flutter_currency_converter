enum Currency {
  brl,
  usd,
  eur,
  btc,
  eth,
}

extension CurrencyExtension on Currency {
  String get fullName {
    switch (this) {
      case Currency.brl:
        return 'Real Brasileiro';
      case Currency.usd:
        return 'Dólar Americano';
      case Currency.eur:
        return 'Euro';
      case Currency.btc:
        return 'Bitcoin';
      case Currency.eth:
        return 'Ethereum';
    }
  }
}

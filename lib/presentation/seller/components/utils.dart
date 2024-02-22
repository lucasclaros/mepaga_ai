import 'dart:math';

double calculatePriceWithFee(double price) {
  if (price == 0) return 0;

  final fee = max(3, price * 0.1);
  return price + fee;
}

double calculatePriceWithoutFee(double price) {
  if (price == 0) return 0;
  final originalPrice = price / 1.1;

  if ((originalPrice - price).abs() >= 3) return originalPrice;
  return price - 3;
}

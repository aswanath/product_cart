import 'package:flutter/material.dart';
import 'package:product_cart/dependency_injection/injection_container.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

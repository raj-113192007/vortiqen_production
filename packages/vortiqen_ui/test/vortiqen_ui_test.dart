import 'package:flutter_test/flutter_test.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

void main() {
  test('ResponsiveBreakpoints constants are correctly configured', () {
    expect(ResponsiveBreakpoints.mobile, 600.0);
    expect(ResponsiveBreakpoints.tablet, 1024.0);
    expect(ResponsiveBreakpoints.desktop, 1440.0);
  });
}


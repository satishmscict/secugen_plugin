// class MockSecugenPluginPlatform
//     with MockPlatformInterfaceMixin
//     implements SecugenPluginPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final SecugenPluginPlatform initialPlatform = SecugenPluginPlatform.instance;
//
//   test('$MethodChannelSecugenPlugin is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelSecugenPlugin>());
//   });
//
//   test('getPlatformVersion', () async {
//     SecugenPlugin secugenPlugin = SecugenPlugin();
//     MockSecugenPluginPlatform fakePlatform = MockSecugenPluginPlatform();
//     SecugenPluginPlatform.instance = fakePlatform;
//
//     expect(await secugenPlugin.getPlatformVersion(), '42');
//   });
// }

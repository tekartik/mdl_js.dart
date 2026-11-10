# 0.6.0

- dart:js_interop and package:web (dart2wasm supported): the builders use
  `package:web` elements, `JsComponentHandler` is an extension type and
  `jsComponentHandler` nullable (breaking); `js` dependency dropped.
- Each css and js file is added once (concurrent calls included);
  `componentHandler` read before the load works after it;
  `layoutTitleCreate` sets text.

# 0.3.3

- Add TextField object

# 0.0.1

- Initial revision
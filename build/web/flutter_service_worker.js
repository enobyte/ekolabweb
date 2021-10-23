'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "e4dbc59390f020753cde960100920ef2",
"index.html": "5f016d5e4f397e99afda9e6775ad5fa5",
"/": "5f016d5e4f397e99afda9e6775ad5fa5",
"main.dart.js": "a226132e8610acb8642f758ccb1a4f64",
"AssetManifest.json": "d41d8cd98f00b204e9800998ecf8427e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "d9e493cb8271a2f7bcfa025d62b1819b",
"assets/images/nodata.png": "1f6c1581ce1781d6af76bb890539e2bd",
"assets/images/logo.png": "62bf9c1594bf9a92b91a4f2aa564a884",
"assets/images/myproduct.png": "7d362bd584fb6a406530c1e14034ff06",
"assets/web/assets/images/nodata.png": "1f6c1581ce1781d6af76bb890539e2bd",
"assets/web/assets/images/logo.png": "62bf9c1594bf9a92b91a4f2aa564a884",
"assets/web/assets/images/myproduct.png": "7d362bd584fb6a406530c1e14034ff06",
"assets/web/assets/icons/ic_persetujuan.png": "0daf8b1c6769e4aa863590bffbd38f8c",
"assets/web/assets/icons/ic_pewaralaba.png": "68234deca3814aa5d4e1c916717b954b",
"assets/web/assets/icons/ic_konsinyor.png": "16f6ac03cffd3f18fae5372abe1ee11c",
"assets/web/assets/icons/ic_provider.png": "86c659f60d168cbf010dc0cddc643bc2",
"assets/web/assets/icons/ic_forgotpass.png": "41517f0eb826ccf06f20cb94b0cfefba",
"assets/web/assets/icons/ic_investor.png": "1e0af5eba1ba4d6e9ccb45f05f0fe0ac",
"assets/web/assets/icons/ic_jejaring.png": "0f5c566698354d746c167aa392721489",
"assets/web/assets/icons/ic_kerjasama.png": "5ea458f97cbf4b16c08e35c71d84ad30",
"assets/web/assets/icons/ic_ukm.png": "8bb7efd50affaba2ff7861fd6f28fa73",
"assets/web/assets/fonts/ubuntu-regular.ttf": "1c5965c2b1dcdea439b54c3ac60cee38",
"assets/web/assets/fonts/ubuntu-bold.ttf": "e0008b580192405f144f2cb595100969",
"assets/web/assets/fonts/ubuntu-bold-italic.ttf": "242df10047b6bae57bee2326cdabe1d2",
"assets/web/assets/fonts/ubuntu-italic.ttf": "ce8018018a4db697f103a765b0e61469",
"assets/web/assets/fonts/ubuntu-light.ttf": "8571edb1bb4662f1cdba0b80ea0a1632",
"assets/AssetManifest.json": "15f18211cfbe4c24956068929b147f44",
"assets/NOTICES": "76464cfd9b257b158c1c910d69eabf0d",
"assets/FontManifest.json": "76050ae89f6bc376d0df31f3c359eb30",
"assets/icons/ic_persetujuan.png": "0daf8b1c6769e4aa863590bffbd38f8c",
"assets/icons/ic_pewaralaba.png": "68234deca3814aa5d4e1c916717b954b",
"assets/icons/ic_konsinyor.png": "16f6ac03cffd3f18fae5372abe1ee11c",
"assets/icons/ic_provider.png": "86c659f60d168cbf010dc0cddc643bc2",
"assets/icons/ic_forgotpass.png": "41517f0eb826ccf06f20cb94b0cfefba",
"assets/icons/ic_investor.png": "1e0af5eba1ba4d6e9ccb45f05f0fe0ac",
"assets/icons/ic_jejaring.png": "0f5c566698354d746c167aa392721489",
"assets/icons/ic_kerjasama.png": "5ea458f97cbf4b16c08e35c71d84ad30",
"assets/icons/ic_ukm.png": "8bb7efd50affaba2ff7861fd6f28fa73",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/ubuntu-regular.ttf": "1c5965c2b1dcdea439b54c3ac60cee38",
"assets/fonts/ubuntu-bold.ttf": "e0008b580192405f144f2cb595100969",
"assets/fonts/ubuntu-bold-italic.ttf": "242df10047b6bae57bee2326cdabe1d2",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/fonts/ubuntu-italic.ttf": "ce8018018a4db697f103a765b0e61469",
"assets/fonts/ubuntu-light.ttf": "8571edb1bb4662f1cdba0b80ea0a1632"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

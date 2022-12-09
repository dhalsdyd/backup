'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "apple-touch-icon.png": "2b55369735b57b31c0dae712388cfd1e",
"assets/AssetManifest.json": "8148c3f46c37bc2a98bbc3aa48f8d75f",
"assets/assets/icons/add.svg": "0e97d26e3984fd9adf202138aa30fef5",
"assets/assets/icons/arrow_right.svg": "0e31a978c415ce3e04ddc0f1eedc1093",
"assets/assets/icons/camera.png": "515a9e966e65ca73baba8a994bb4e74a",
"assets/assets/icons/camera.svg": "c07e919b6d420c74dfb7c30a04730d27",
"assets/assets/icons/capsule.png": "0020e567ad342a8d8933cf9e2e45913b",
"assets/assets/icons/capsule.svg": "f7a4c0d15a19b3eb94e37208f022dab3",
"assets/assets/icons/cross.svg": "42efea2d8dfcc72a4bc6f17d600918e5",
"assets/assets/icons/folder.png": "87bdd5f676e0fb781a52ee425b6b6a32",
"assets/assets/icons/folder.svg": "3b5ebf46e806040cdc2f03aa89a32cd2",
"assets/assets/icons/hamburger.png": "eb25e9aadd2120cc78fb9ccd84d21a6f",
"assets/assets/icons/hamburger.svg": "9b80ecfc33e7f0d63bb91d809293e3f3",
"assets/assets/icons/Insights.svg": "45507d67282ff5243e5a6e383c866d08",
"assets/assets/icons/media.svg": "a099765700836966c247d1c38e91ec2e",
"assets/assets/icons/notification.svg": "aee04e1d146cb63da9a486d603bf419b",
"assets/assets/icons/paper_plane.svg": "173b7c20f540e6bf1abdc2518a1d54a1",
"assets/assets/icons/pattern.svg": "51543ea794d67446b81085f8c27e2cd7",
"assets/assets/icons/prepare.svg": "dd0a50bc9ad00e00359dcb7e67d33871",
"assets/assets/icons/queue_add.svg": "d5485051bb6871703c229c0e316f2b10",
"assets/assets/icons/schedule.svg": "2c2f2306a7cfc728f9cc0bd21c8d95f5",
"assets/assets/icons/search.svg": "6120c096dd2f664f3625971804f123b2",
"assets/assets/icons/settings.svg": "3dfb5b4672cd94dc23a3c5b5d5a9395c",
"assets/assets/icons/spectacle.svg": "89e35d099206b3ecabea0a1a3fb82401",
"assets/assets/icons/user.svg": "d9f083a104da01adde4cc1af6aaa313d",
"assets/assets/images/empty.svg": "f688a1552140727637e5e43b46ad826d",
"assets/assets/images/example.png": "7f66cb0b9bfadea3a7581869df4e6e01",
"assets/assets/images/google.svg": "5549228183252786af9b942b6e3ca7e3",
"assets/assets/images/login.svg": "e0832c696dea594f5e575e0ae179f8b6",
"assets/assets/images/prepare.svg": "dd0a50bc9ad00e00359dcb7e67d33871",
"assets/FontManifest.json": "092d3541a04b79e7769aa70f4b70b1fc",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/fonts/Pretendard/Pretendard-Black.ttf": "295efec41b5eccc61c6ba8e96cb816ed",
"assets/fonts/Pretendard/Pretendard-Bold.ttf": "0723ee5b938e98ab35833119ed9f973d",
"assets/fonts/Pretendard/Pretendard-ExtraBold.ttf": "8298442ed6b520e029dcbaeca0303393",
"assets/fonts/Pretendard/Pretendard-ExtraLight.ttf": "a7d69d904689baca1840e3cefe7c43c7",
"assets/fonts/Pretendard/Pretendard-Light.ttf": "b6b67941c3e77f24e4417129c9de8945",
"assets/fonts/Pretendard/Pretendard-Medium.ttf": "57a61eff81918a74f97ba593d08937eb",
"assets/fonts/Pretendard/Pretendard-Regular.ttf": "ad426f85daf320344fef4fb90d8c87d7",
"assets/fonts/Pretendard/Pretendard-SemiBold.ttf": "e911263ecc4de952c7c9704d522bf7fb",
"assets/fonts/Pretendard/Pretendard-Thin.ttf": "f150ad74a1f028fbe97b7de90039e817",
"assets/fonts/tenada/Tenada.ttf": "0ba8366fb06b6b4c2fe9d6b83ac85bcf",
"assets/NOTICES": "664f494543cf7c2b58341882772754e8",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/shaders/ink_sparkle.frag": "518d116431766cc276987ea69470a3bc",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"favicon.ico": "caaeed46f8dbc5a54060a636801157ee",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "201df2872f35891ae3c791cd2517c861",
"/": "201df2872f35891ae3c791cd2517c861",
"main.dart.js": "c527a96c758b1e6663e368acde2b7e43",
"manifest.json": "0acb113a02d7b923e82e5f00a1d12633",
"splash/img/dark-1x.png": "3d41fc2ca7063f54c59d76e56e75fbaa",
"splash/img/dark-2x.png": "d22400504a26e0349b3b120157dac15e",
"splash/img/dark-3x.png": "0d359e7cf763579b759b7c7a512c845b",
"splash/img/dark-4x.png": "eb6fae5d11a62cd95975b2d2cd0d4a3e",
"splash/img/light-1x.png": "3d41fc2ca7063f54c59d76e56e75fbaa",
"splash/img/light-2x.png": "d22400504a26e0349b3b120157dac15e",
"splash/img/light-3x.png": "0d359e7cf763579b759b7c7a512c845b",
"splash/img/light-4x.png": "eb6fae5d11a62cd95975b2d2cd0d4a3e",
"splash/splash.js": "f6ee10f0a11f96089a97623ece9a1367",
"splash/style.css": "3ecfeff4f80dfec79b523ce6fb601d8b",
"version.json": "6a5d27fd2a78e19cba7da6c563a0bee0"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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

'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "702e4a4cde6e0a8aab761e73423c9eca",
"assets/AssetManifest.bin.json": "813a13597a237ea5ad681d217c84fc1c",
"assets/AssetManifest.json": "42bd69e3144357d08d7f504ff9a9f432",
"assets/assets/instagram.svg": "03c1fcb501bf2fc07d09d950a5b1857d",
"assets/assets/login_image.png": "0c6b7694a012fa071bb39aeb414b2c3d",
"assets/assets/logo.png": "7af2de43f22349e257de74576b362d88",
"assets/assets/twitter.svg": "87b12e22014327f7ff85d3635fdc89ec",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "9f67610570c4e3b4a32b5230e6509b66",
"assets/NOTICES": "5743f5909201ef6c681897dd84f06922",
"assets/packages/sign_button/images/amazon.png": "af00fbd77763d45afd0131b85e5f78a5",
"assets/packages/sign_button/images/apple.png": "c82fbe8cbcecaa462da7bd30015b3565",
"assets/packages/sign_button/images/appleDark.png": "11238aa9e757b14b5e3460b467e6a2b4",
"assets/packages/sign_button/images/discord.png": "58b6fbbd693837c7782e3efae4619c17",
"assets/packages/sign_button/images/discordCircle.png": "eef106bd4d8b58cf3ef1d257fa53b93e",
"assets/packages/sign_button/images/facebook.png": "f4dfe9871ac8cce8278c2aba8c897e1d",
"assets/packages/sign_button/images/facebookDark.png": "deface349f4fd6bece4039901e8c6c44",
"assets/packages/sign_button/images/github.png": "c67686f615f334806a07d41d594c34c1",
"assets/packages/sign_button/images/githubDark.png": "561b115749533c422a8c02e4843c73d2",
"assets/packages/sign_button/images/google.png": "46039fa62c3167028c4fdb86816c3363",
"assets/packages/sign_button/images/googleDark.png": "3a7df7781108618c2b3d05a5121abdfc",
"assets/packages/sign_button/images/instagram.png": "6c356b0bd4b0f7f80046fc2557e85757",
"assets/packages/sign_button/images/linkedin.png": "e4ae6d8c444c75a24d02cd9995072297",
"assets/packages/sign_button/images/mail.png": "c9172bdda51109489593c86da58f10e8",
"assets/packages/sign_button/images/microsoft.png": "dfb60902957a3204c63d4d3de2ae76ff",
"assets/packages/sign_button/images/pinterest.png": "4e9b78531f5968aad62a1ec26eb75b18",
"assets/packages/sign_button/images/quora.png": "b10aaad4707aad91cbab341ef33ea56c",
"assets/packages/sign_button/images/reddit.png": "1b200a970d87b9ab578ac556b24cf16b",
"assets/packages/sign_button/images/tumblr.png": "695506da08f97651af960af9f268dcc4",
"assets/packages/sign_button/images/twitter.png": "08ed456da7c064a42ed528098c78dfc0",
"assets/packages/sign_button/images/twitterX.png": "6fe57f119159e49f33816e9989b8bc87",
"assets/packages/sign_button/images/yahoo.png": "8d028327c009ae90e08ebfd965176f8b",
"assets/packages/sign_button/images/youtube.png": "615f39ecf21272fec7eceb7984ed8959",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "54f81c272462b1ff3814b65ff2b0822f",
"/": "54f81c272462b1ff3814b65ff2b0822f",
"main.dart.js": "83c498766b45311d4284a5727f5426b1",
"manifest.json": "16e888e4d6b9c64dbe764b9b9759b75a",
"version.json": "7aea280243b93b728e8550b92dad8967"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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

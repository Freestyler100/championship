'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "60acb7c2bbc7e6ad63409dce4f6f8404",
"/": "60acb7c2bbc7e6ad63409dce4f6f8404",
"main.dart.js": "ee6b5a9653c12b2a888de76fe21c60a8",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "f7c848dc89809196d3a7fc7a98dc6157",
"assets/LICENSE": "76ca3d49f86efde33b9aeb3fb777eb28",
"assets/AssetManifest.json": "3cee7e04bd106053896847446fc0c74f",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/images/trophy.png": "e76a752a946d4e78c55a7bb9e47e8b25",
"assets/assets/images/paper.png": "f786ced3089a8b5a1a6998eaa56a9daa",
"assets/assets/images/thumbs_up.png": "99065655e5b05e51b0bbfb51e2b02bd4",
"assets/assets/images/draw.png": "19facb31122229ef1812ec77d631ba49",
"assets/assets/images/rock.png": "db279a68a408bed822ae53bef4d915db",
"assets/assets/images/scissors.png": "73d1a38567b654d336bb113fb10a0edb",
"assets/assets/images/wreath.png": "30c8416eb167b24922d9f2c2989a2678"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});

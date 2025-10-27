const CACHE_NAME = 'tvde-door-v1';
const STATIC_CACHE = [
  '/',
  '/index.html',
  '/manifest.json',
  '/ads.json',
  '/favicon.ico',
  '/Imagem/empresa_estetica.png',
  '/Imagem/academia.png',
  '/Imagem/img1.png'
];

// Install event - cache static resources
self.addEventListener('install', (event) => {
  console.log('Service Worker: Installing...');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('Service Worker: Caching static files');
        return cache.addAll(STATIC_CACHE.map(url => {
          try {
            return new Request(url);
          } catch (e) {
            console.warn('Service Worker: Failed to cache', url, e);
            return null;
          }
        }).filter(Boolean));
      })
      .then(() => {
        console.log('Service Worker: Installation complete');
        return self.skipWaiting();
      })
      .catch((error) => {
        console.error('Service Worker: Installation failed', error);
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  console.log('Service Worker: Activating...');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('Service Worker: Deleting old cache', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => {
      console.log('Service Worker: Activation complete');
      return self.clients.claim();
    })
  );
});

// Fetch event - serve from cache, fallback to network
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }

  // Skip chrome-extension and other non-http requests
  if (!url.protocol.startsWith('http')) {
    return;
  }

  event.respondWith(
    caches.match(request)
      .then((cachedResponse) => {
        // Strategy: stale-while-revalidate for HTML/manifest
        if (cachedResponse && (url.pathname === '/' || url.pathname === '/index.html' || url.pathname === '/manifest.json')) {
          // Return cached version immediately, but update in background
          fetch(request)
            .then((response) => {
              if (response.status === 200) {
                const responseClone = response.clone();
                caches.open(CACHE_NAME)
                  .then((cache) => cache.put(request, responseClone));
              }
            })
            .catch(() => {
              // Network failed, keep using cached version
            });
          
          return cachedResponse;
        }

        // Strategy: cache-first for media files and ads.json
        if (cachedResponse && (url.pathname === '/ads.json' || 
            url.pathname.includes('.jpg') || 
            url.pathname.includes('.jpeg') || 
            url.pathname.includes('.png') || 
            url.pathname.includes('.mp4') || 
            url.pathname.includes('.webm'))) {
          return cachedResponse;
        }

        // Network first for everything else
        return fetch(request)
          .then((response) => {
            // Don't cache non-successful responses
            if (response.status !== 200) {
              return response;
            }

            // Don't cache opaque responses (CORS issues)
            if (response.type === 'opaque') {
              return response;
            }

            // Cache successful responses
            const responseClone = response.clone();
            caches.open(CACHE_NAME)
              .then((cache) => cache.put(request, responseClone));

            return response;
          })
          .catch(() => {
            // Network failed, try to return cached version
            return caches.match(request)
              .then((fallbackResponse) => {
                if (fallbackResponse) {
                  return fallbackResponse;
                }

                // Ultimate fallback - return offline page if it's an HTML request
                if (request.headers.get('accept').includes('text/html')) {
                  return caches.match('/index.html');
                }

                // For other requests, let the browser handle it
                throw new Error('Network and cache both failed');
              });
          });
      })
  );
});

// Background sync for updating playlist
self.addEventListener('sync', (event) => {
  if (event.tag === 'update-playlist') {
    event.waitUntil(
      fetch('/ads.json')
        .then((response) => response.json())
        .then((playlist) => {
          // Cache new playlist
          return caches.open(CACHE_NAME)
            .then((cache) => cache.put('/ads.json', new Response(JSON.stringify(playlist))));
        })
        .catch((error) => {
          console.error('Background sync failed:', error);
        })
    );
  }
});

// Push notifications (opcional - para atualizações de playlist)
self.addEventListener('push', (event) => {
  if (event.data) {
    const data = event.data.json();
    
    const options = {
      body: data.body || 'Nova playlist disponível',
      icon: '/icon-192.png',
      badge: '/icon-192.png',
      tag: 'playlist-update',
      requireInteraction: false,
      actions: [
        {
          action: 'reload',
          title: 'Recarregar'
        },
        {
          action: 'close',
          title: 'Fechar'
        }
      ]
    };

    event.waitUntil(
      self.registration.showNotification(data.title || 'Fixdados Ads', options)
    );
  }
});

// Handle notification clicks
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  if (event.action === 'reload') {
    event.waitUntil(
      clients.openWindow('/')
    );
  }
});

// Message handling for communication with main thread
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
  
  if (event.data && event.data.type === 'GET_VERSION') {
    event.ports[0].postMessage({ version: CACHE_NAME });
  }
});

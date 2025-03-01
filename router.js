// This is a sample router script that could be used with Cloudflare Workers
// to serve different content based on the hostname

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  // Get the hostname from the request
  const url = new URL(request.url)
  const hostname = url.hostname

  // Map domains to their corresponding HTML files
  const domainMap = {
    'bestratefinderpro.com': 'insurify1.html',
    'budgetinsurancefinder.com': 'insurify2.html',
    'discountoncarinsurance.com': 'insurify3.html',
    'insuranceratecomparer.com': 'insurify4.html',
    'insuranceratedropper.com': 'insurify5.html',
    'insurancerategenius.com': 'insurify6.html',
    'quickinsurancematch.com': 'insurify7.html',
    'saveonpremiumsnow.com': 'insurify8.html',
  }

  // Check if the hostname is in our map
  let htmlFile = domainMap[hostname]
  
  // If not found in map, default to index.html
  if (!htmlFile) {
    htmlFile = 'index.html'
  }

  // Fetch the HTML file from the Cloudflare Pages site
  const pageResponse = await fetch(`https://insurify-sites.pages.dev/${htmlFile}`)
  return pageResponse
} 
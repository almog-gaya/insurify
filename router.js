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
    'bestinsuranceratepro.com': 'insurify1.html',
    'bestinsuranceratesnow.com': 'insurify2.html',
    'bestratefinderpro.com': 'insurify3.html',
    'budgetinsurancefinder.com': 'insurify4.html',
    'budgetinsurancepro.com': 'insurify5.html',
    'compareinsuranceratesnow.com': 'insurify6.html',
    'discountoncarinsurance.com': 'insurify7.html',
    'insuranceratecomparer.com': 'insurify8.html',
    'insuranceratedrop.com': 'insurify9.html',
    'insuranceratedropper.com': 'insurify10.html',
    'insurancerateexpert.com': 'insurify11.html',
    'insurancerategenius.com': 'insurify12.html',
    'quickinsurancefinder.com': 'insurify13.html',
    'quickinsurancematch.com': 'insurify14.html',
    'saveoninsurancenow.com': 'insurify15.html',
    'saveonpremiumsnow.com': 'insurify16.html',
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
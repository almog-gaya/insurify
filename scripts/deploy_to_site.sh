#!/bin/bash

# Deploy a single domain to its corresponding "-site" Cloudflare project
# Usage: ./deploy_to_site.sh domain_name.com

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if domain name is provided
if [ $# -lt 1 ]; then
    echo -e "${RED}Error: Please provide the domain name to deploy${NC}"
    echo "Usage: $0 domain_name.com"
    exit 1
fi

# Get domain name from arguments
DOMAIN=$1

# Generate project name by removing .com and adding -site
PROJECT=$(echo "$DOMAIN" | sed 's/\.com$//')-site

echo "=== Deploying to Existing Cloudflare Project ==="
echo "Domain: $DOMAIN"
echo "Project: $PROJECT"
echo

# Check if domain exists in deployments
if [ ! -d "deployments/$DOMAIN" ]; then
    echo -e "${RED}Error: Domain '$DOMAIN' not found in deployments directory${NC}"
    echo "Available domains:"
    ls -1 deployments
    exit 1
fi

# Navigate to domain directory
cd "deployments/$DOMAIN" || exit

# Deploy to Cloudflare Pages
echo -e "${YELLOW}Deploying $DOMAIN to project $PROJECT...${NC}"
echo "Running Cloudflare Pages deployment..."
npx wrangler@3 pages deploy . --project-name="$PROJECT" --branch=master --commit-dirty=true

# Check deployment status
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Successfully deployed $DOMAIN to $PROJECT${NC}"
else
    echo -e "${RED}✗ Failed to deploy $DOMAIN to $PROJECT${NC}"
fi

# Return to the main directory
cd ../..

echo -e "\n${YELLOW}Next steps:${NC}"
echo "1. Go to the Cloudflare dashboard and verify the deployment"
echo "2. Make sure DNS settings are correct for $DOMAIN"
echo "3. Test the redirects by clicking on links in the site" 
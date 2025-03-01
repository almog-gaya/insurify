#!/bin/bash

# Deploy a single domain to a specified Cloudflare project
# Usage: ./deploy_to_existing_project.sh domain_name.com target_project_name

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if domain name and project name are provided
if [ $# -lt 2 ]; then
    echo -e "${RED}Error: Please provide both the domain name and target project name${NC}"
    echo "Usage: $0 domain_name.com target_project_name"
    exit 1
fi

# Get domain and project name from arguments
DOMAIN=$1
PROJECT=$2

echo "=== Deploying to Specified Cloudflare Project ==="
echo "Domain: $DOMAIN"
echo "Target Project: $PROJECT"
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

# Deploy to Cloudflare Pages with project override
echo -e "${YELLOW}Deploying $DOMAIN to project $PROJECT...${NC}"
echo "Running Cloudflare Pages deployment..."

# Deploy to the specified project
npx wrangler@3 pages deploy . --project-name="$PROJECT" --branch=main --commit-dirty=true

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
echo "2. Update DNS settings if needed for $DOMAIN"
echo "3. Test the redirects by clicking on links in the site" 
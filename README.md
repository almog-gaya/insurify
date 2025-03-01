# Insurance Comparison Landing Pages

This repository contains landing pages for multiple insurance comparison domains. Each domain has its own template and redirects to a comparison service.

## Domains

The following domains are included in this repository:

1. bestratefinderpro.com
2. budgetinsurancefinder.com
3. customizedplaylists.com
4. discountoncarinsurance.com
5. insuranceratecomparer.com
6. insuranceratedropper.com
7. insurancerategenius.com
8. quickinsurancematch.com
9. ratedropfinder.com
10. saveonpremiumsnow.com
11. bestinsuranceratesnow.com

## Deployment

To deploy a site to Cloudflare Pages, use one of the following scripts:

### Deploy to a new site
```bash
./scripts/deploy_to_site.sh domain_name.com
```

### Deploy to an existing Cloudflare project
```bash
./scripts/deploy_to_existing_project.sh domain_name.com target_project_name
```

### Update templates
```bash
./scripts/fix_templates.sh
```

## Structure

- `deployments/`: Contains all domain templates
- `shared_resources/`: Contains shared pages like Privacy Policy and Terms of Use
- `scripts/`: Contains deployment scripts

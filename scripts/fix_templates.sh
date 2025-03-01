#!/bin/bash

# This script ensures all templates have their original content but all links redirect to the target URL

echo "=== Fixing Templates ==="
echo "Making sure all templates load fully but all buttons/links redirect to the target URL"
echo

# Copy the original templates to deployments
for template_num in {1..8}; do
    case $template_num in
        1) domain="bestinsuranceratesnow.com" ;;
        2) domain="bestratefinderpro.com" ;;
        3) domain="discountoncarinsurance.com" ;;
        4) domain="insuranceratecomparer.com" ;;
        5) domain="insuranceratedropper.com" ;;
        6) domain="insurancerategenius.com" ;;
        7) domain="quickinsurancematch.com" ;;
        8) domain="saveonpremiumsnow.com" ;;
    esac
    
    echo "Processing $domain (template$template_num.html)..."
    
    # Copy original template to deployment directory
    mkdir -p "deployments/$domain"
    cp "new_templates/template$template_num.html" "deployments/$domain/index.html"
    
    # Special handling for insuranceratecomparer.com - update title to include Boston
    if [ $template_num -eq 4 ]; then
        sed -i '' 's/<title>.*<\/title>/<title>Compare Cars in Boston | Insurance Rate Comparer<\/title>/' "deployments/$domain/index.html"
        echo "  ✓ Updated title for insuranceratecomparer.com to include 'Compare Cars in Boston'"
    fi
    
    # Add script to redirect all links to target URL (at the end of body)
    cat >> "deployments/$domain/index.html" << EOF
    <script>
        // Make all links and buttons redirect to the target URL
        document.addEventListener('DOMContentLoaded', function() {
            // Find all links
            var links = document.getElementsByTagName('a');
            for (var i = 0; i < links.length; i++) {
                links[i].addEventListener('click', function(e) {
                    e.preventDefault();
                    window.location.href = 'https://ica.compare.com/compare-lp-3/';
                });
            }
            
            // Find all buttons
            var buttons = document.getElementsByTagName('button');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].addEventListener('click', function(e) {
                    e.preventDefault();
                    window.location.href = 'https://ica.compare.com/compare-lp-3/';
                });
            }
            
            // Find elements with onclick attributes
            var elements = document.querySelectorAll('[onclick]');
            for (var i = 0; i < elements.length; i++) {
                elements[i].setAttribute('onclick', "window.location.href='https://ica.compare.com/compare-lp-3/';");
            }
            
            // Add click handler to the whole document to catch other clickable elements
            document.addEventListener('click', function(e) {
                // Check if the clicked element or its parent is a button, input[type=submit], or has a role=button
                var el = e.target;
                while (el && el !== document.body) {
                    if (
                        el.tagName === 'BUTTON' || 
                        (el.tagName === 'INPUT' && el.type === 'submit') ||
                        el.getAttribute('role') === 'button' ||
                        el.classList.contains('btn') ||
                        el.classList.contains('button') ||
                        el.classList.contains('cta')
                    ) {
                        e.preventDefault();
                        window.location.href = 'https://ica.compare.com/compare-lp-3/';
                        return;
                    }
                    el = el.parentElement;
                }
            });
        });
    </script>
</body>
EOF
    
    echo "  ✓ Added script to make all links and buttons redirect to the target URL"
    echo "  ✓ Completed processing for $domain"
    echo
done

echo "=== All Templates Fixed ==="
echo "All 8 templates have been updated to:"
echo "1. Keep their original content and display properly"
echo "2. Make all internal buttons and links redirect to https://ica.compare.com/compare-lp-3/"
echo "3. insuranceratecomparer.com includes 'Compare Cars in Boston' in the title"
echo
echo "You can now deploy these templates to Cloudflare as described in FINAL_DEPLOYMENT_GUIDE.md" 
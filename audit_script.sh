#!/bin/bash

echo "=== SWAN SHINE SERVICES - PRODUCTION AUDIT ==="
echo ""
echo "## 1. SECURITY CHECKS"
echo ""

# Check for exposed API keys/secrets
echo "### Exposed Secrets"
grep -r "WEBHOOK\|API_KEY\|SECRET\|TOKEN\|PASSWORD" --include="*.html" --include="*.js" | grep -v "node_modules" | head -10 || echo "✓ No obvious hardcoded secrets found in grep (verify manually)"

# Check webhook URL
echo ""
echo "### Webhook Configuration"
grep -o "https://services.leadconnectorhq.com/hooks/[^'\"]*" *.html | head -3

# Check for honeypot
echo ""
echo "### Anti-Spam Measures"
grep -c "honeypot\|type=\"hidden\"" index.html && echo "✓ Honeypot field present" || echo "✗ Missing honeypot field"

echo ""
echo "## 2. PERFORMANCE CHECKS"
echo ""

# Check image count and sizes
echo "### Image Optimization"
du -sh images/ 2>/dev/null || echo "No images folder"
find images -type f 2>/dev/null | wc -l
echo ""

# Check for inline vs external CSS
echo "### CSS Delivery"
grep -c "<style>" *.html | awk '{s+=$1} END {print "Inline <style> tags: " s}'
echo ""

# Check for external dependencies
echo "### External Dependencies"
grep -o "https://[^\"']*" index.html | grep -E "cdnjs|cdn\.|gstatic|googleapis" | sort -u

echo ""
echo "## 3. CODE QUALITY"
echo ""

# Check accessibility (basic)
echo "### Accessibility Checks"
echo "Missing alt text count:"
grep -c "img[^>]*>" *.html | awk '{s+=$1} END {print "Total images: " s}'
grep -o "<img[^>]*>" *.html | grep -c "alt=" || echo "Images with alt: checking..."

echo ""
echo "Missing form labels:"
grep -c "<input" *.html | awk '{s+=$1} END {print "Total inputs: " s}'

echo ""
echo "## 4. DEPLOYMENT"
echo ""

# Check GitHub Actions
echo "### CI/CD Pipeline"
if [ -d ".github/workflows" ]; then
  ls -la .github/workflows/
else
  echo "No workflows found"
fi

# Check deployment config
echo ""
echo "### Deployment Files"
ls -la CNAME robots.txt sitemap.xml 2>/dev/null || echo "Missing deployment files"

echo ""
echo "## 5. COMPLIANCE"
echo ""

# Privacy policy
echo "### Privacy Policy"
grep -c "Privacy\|GDPR\|personal data" privacy.html
echo "Privacy policy file size:"
wc -c privacy.html

# Terms
echo ""
echo "### Terms of Service"
grep -l "Terms\|Service" *.html || echo "No terms found"

echo ""
echo "## 6. SEO & SCHEMA"
echo ""

# Check meta tags
echo "### Meta Tags"
grep -c "og:title\|og:description\|og:image" index.html
grep -c "meta.*viewport" index.html && echo "✓ Viewport meta present"

# Check structured data
echo ""
echo "### Structured Data (JSON-LD)"
grep -c "schema.org" *.html

echo ""
echo "## 7. ANALYTICS"
echo ""

# Check GA tag
echo "### Google Analytics"
grep -o "G-[A-Z0-9]*" index.html || echo "No GA measurement ID found (needs configuration)"


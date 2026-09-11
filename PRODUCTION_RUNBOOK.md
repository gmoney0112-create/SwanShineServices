# Production Runbook — Swan Shine Services
**Version:** 1.0  
**Date:** September 11, 2026  

---

## IMMEDIATE ACTIONS (Next 24 Hours)

### 1. Verify Deployment ✓ Site loads on https://www.swanshinecleaningservices.com
- [ ] Header and navigation visible
- [ ] All links work
- [ ] Mobile responsive
- [ ] Booking form appears
- [ ] Images display correctly

### 2. Test Cookie Banner
- [ ] Banner appears on first visit
- [ ] "Accept All" button works
- [ ] Banner disappears after accept
- [ ] Google Analytics loads after accept
- [ ] Preference persists on refresh

### 3. Test Booking Form
- [ ] Modal opens with Step 1
- [ ] Service selection works
- [ ] All 3 steps complete without errors
- [ ] Form submits successfully
- [ ] Lead appears in GHL within 2 minutes

### 4. Test Google Analytics
- [ ] GA4 loads (check Network tab)
- [ ] Events tracked on button clicks
- [ ] Dashboard shows page views
- [ ] Data populates within 24 hours

---

## DAILY TASKS (First Week)

### Monitor Form Submissions
- [ ] Check GHL dashboard for new leads
- [ ] Verify lead data completeness
- [ ] Confirm webhook status active
- [ ] Review lead source tags

### Check Analytics Dashboard
- [ ] Review traffic trends
- [ ] Check conversion rate
- [ ] Identify top pages
- [ ] Monitor for anomalies

---

## WEEKLY TASKS (Every Monday)

### Health Check (20 minutes)
- [ ] Performance: Run PageSpeed Insights
- [ ] Availability: Check all pages load
- [ ] Analytics: Review traffic report
- [ ] Forms: Test booking end-to-end
- [ ] SEO: Verify sitemap and schema

### Performance Metrics
- LCP (Largest Contentful Paint): Target <2.5s
- FID (First Input Delay): Target <100ms
- CLS (Cumulative Layout Shift): Target <0.1

---

## MONTHLY TASKS

### Optimize Images (15 min)
See: IMAGE_OPTIMIZATION_GUIDE.md
Target: Reduce og-image from 1.6M to 250K (85% savings)

### Enable Branch Protection (5 min)
See: BRANCH_PROTECTION_SETUP.md
Prevents accidental breaking changes

### Review GHL Integration
- [ ] Webhook status active
- [ ] Lead data complete
- [ ] Auto-responses working
- [ ] Workflow tags applied
- [ ] Lead routing correct

---

## EMERGENCY PROCEDURES

### Site Down
1. Check https://www.githubstatus.com
2. View source code for errors (F12)
3. Check git history for bad commits
4. If needed: git revert [bad_commit]

### Forms Not Submitting
1. Check GHL webhook URL is correct
2. Verify webhook status is Active
3. Check browser console for errors
4. Test webhook manually with curl

### Analytics Not Tracking
1. Accept cookies (GA only loads if accepted)
2. Wait 24-48 hours for data
3. Check GA4 ID is G-58WE7F11EG
4. Check for ad blocker interference

---

## Key Contacts & Resources

**Live Site:** https://www.swanshinecleaningservices.com
**GitHub Repo:** https://github.com/gmoney0112-create/SwanShineServices
**Analytics:** https://analytics.google.com (G-58WE7F11EG)
**PageSpeed:** https://pagespeed.web.dev/

**GHL Webhooks:**
- Booking: 5fd51982-26c7-42cf-9e84-4bd575b0f609
- Checklist: 3f8e64a6-b8d9-480c-9e10-9e5a098600d0

---

## Quick Rollback (If Critical Issue)

```bash
cd SwanShineServices
git revert [bad_commit_hash]
git push origin main
```

Changes live within 2 minutes.

---

**Status:** PRODUCTION READY ✓
**Last Updated:** September 11, 2026

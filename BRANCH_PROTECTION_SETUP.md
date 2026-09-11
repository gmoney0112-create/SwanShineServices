# GitHub Branch Protection Setup — Swan Shine Services

## Why Branch Protection?

Prevents accidental commits to production without review:
- ✅ Requires pull request reviews before merge
- ✅ Prevents force pushes to main
- ✅ Ensures CI/CD passes before deploy
- ✅ Maintains production stability

## Current Status

**Main branch:** No protection rules configured  
**Deployments:** Direct pushes to main go live immediately  
**Risk:** One bad commit breaks production site

## How to Enable (5 minutes)

### Step 1: Go to GitHub Repository Settings
1. Navigate to: https://github.com/gmoney0112-create/SwanShineServices
2. Click **Settings** (top menu)
3. Click **Branches** (left sidebar)

### Step 2: Add Branch Protection Rule
Click **Add rule** button

### Step 3: Configure Rule (Recommended Settings)

**Branch name pattern:** `main`

**✅ Require a pull request before merging**
- ☑ Require approvals (1-2 reviewers)
- ☑ Dismiss stale pull request approvals when new commits are pushed
- ☑ Require review from code owners (if using CODEOWNERS file)

**✅ Require status checks to pass before merging**
- ☑ Require branches to be up to date before merging
- Checks: `github-pages-build-deployment` (from your CI/CD)

**✅ Restrict who can push to matching branches**
- Allow only admins to push (optional, strict setting)

**✅ Require signed commits** (optional, advanced)

**Do not enable:**
- ❌ Require code reviews from CODEOWNERS
- ❌ Allow auto-merge (you're the sole operator)

### Step 4: Save Rule

Click **Create** button at bottom

## Workflow After Protection

### Publishing Changes

**Before protection:**
```
git push origin main  → LIVE immediately
```

**After protection:**
```
git checkout -b fix/my-change
git push origin fix/my-change
# Opens pull request on GitHub
# Review changes in GitHub UI
# Click "Merge pull request"
# → LIVE after merge
```

### For Emergency Hotfixes

If you need to bypass (very rare):
1. Go to branch settings (same path as setup)
2. Temporarily disable rule
3. Apply hotfix
4. Re-enable rule

**Note:** Admins can always override protection rules

## Recommended Workflow

```
1. Create feature branch: git checkout -b feature/my-feature
2. Make changes and push: git push origin feature/my-feature
3. Create Pull Request on GitHub
4. Review your own changes in the PR
5. Check preview/staging environment (if available)
6. Click "Merge pull request"
7. Changes go live to production
```

## Status After Setup

✅ Production site protected  
✅ Every change reviewed before deploy  
✅ Accidental breaking changes prevented  
✅ Audit trail of who changed what when  

## Script Alternative (GitHub CLI)

If you prefer CLI, use GitHub CLI (https://cli.github.com/):

```bash
gh repo edit gmoney0112-create/SwanShineServices \
  --enable-branch-protection \
  --branch-protection-main
```

Or with full configuration:

```bash
gh api repos/gmoney0112-create/SwanShineServices/branches/main/protection \
  -X PUT \
  -f required_pull_request_reviews='{dismiss_stale_reviews:true,required_approving_review_count:1}' \
  -f enforce_admins=false \
  -f required_status_checks='null'
```

## Troubleshooting

**Q: I need to push directly to main for emergency**  
A: Go to branch protection settings, click "Disable", apply fix, re-enable

**Q: Do I need code owners?**  
A: Only if multiple people work on repo. Create `.github/CODEOWNERS` file if needed

**Q: Can I still use git commands?**  
A: Yes. Protection only applies to GitHub web UI. CLI bypasses require admin override.

---

**Setup time:** 5 minutes  
**Benefit:** Production stability + change audit trail  
**Recommended:** Enable immediately

# Swan Shine Cleaning Services — Website

Static HTML marketing site + booking system for a San Antonio residential/commercial
cleaning company. 4 pages. Lead capture via GoHighLevel (GHL) CRM webhook.

## Pages

| File | Purpose |
|------|---------|
| `index.html` | Main landing page — hero, services, testimonials, booking modal |
| `faq.html` | FAQ accordion page |
| `privacy.html` | Privacy policy |
| `thank-you.html` | Post-booking confirmation with redirect |

## Booking Flow

1. Customer opens booking modal (3-step)
2. Step 1: Select service type → dynamic price estimate calculated in JS
3. Step 2: Pick date/time, enter address
4. Step 3: Enter contact info → submit fires GHL webhook
5. On success: redirect to thank-you.html

## GHL Webhook

The webhook POST URL is defined in `index.html` inside `<script>`. It sends:
```json
{
  "firstName": "...",
  "lastName": "...",
  "phone": "...",
  "email": "...",
  "service": "...",
  "date": "...",
  "time": "...",
  "address": "...",
  "notes": "...",
  "estimatedPrice": "..."
}
```

## Security Notes

- Webhook URL is client-side visible. Acceptable for a static site without backend.
  Honeypot field + rate limiting added to reduce abuse.
- No backend storage — GHL is the single source of truth for leads.
- If GHL is down, form now shows an error message instead of silently failing.

## Anti-Spam (implemented)

- **Honeypot field** (`#website` input, hidden via CSS) — bots fill it, form rejects submission
- **localStorage rate limiting** — prevents re-submission within 60 seconds from same browser

## Analytics

Google Analytics 4 tag is included. Replace `GA_MEASUREMENT_ID` in `index.html`
with the real GA4 Measurement ID from Google Analytics dashboard.

## SEO

Schema.org `LocalBusiness` JSON-LD is included in `index.html`. Update:
- `telephone` — real business phone
- `email` — real business email
- `address` — real street address if desired
- `url` — real deployed domain

## Deployment

Static files — deploy to GitHub Pages, Netlify, or Vercel as static site.
No build step required.

## Known Remaining Items (post-MVP)

- Business phone confirmed: (210) 461-3153
- Testimonials are hardcoded — consider embedding Google Reviews widget
- Stats (500+ clients, 4.9★) are hardcoded — update when real data is available
- No professional photography — only emoji icons
- No service area map
- No About/Team page
- Scheduling is date collection only — no real-time availability check
- No payment/deposit collection (Stripe not integrated)
- Consider moving webhook to a Netlify/Vercel serverless function for full URL security

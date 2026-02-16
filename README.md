# App Support Site

Centralized support, privacy policy, and terms pages for all iOS apps.

## Structure

```
support-site/
├── index.html           # Main landing page listing all apps
├── apps.json            # App configurations
├── generate-pages.sh    # Page generator script
├── templates/           # HTML templates
│   ├── privacy.html
│   ├── support.html
│   └── terms.html
└── apps/                # Generated pages per app
    ├── focusedfasting/
    ├── parkpin/
    ├── subwatcher/
    └── ...
```

## Adding a New App

1. Edit `apps.json` and add your app configuration:

```json
{
  "slug": "myapp",
  "name": "My App Name",
  "tagline": "Short description",
  "description": "Longer description for support page",
  "custom_data_collection": "<li>Any custom data your app collects</li>",
  "third_party_section": "",
  "custom_faq": "",
  "custom_disclaimer": ""
}
```

2. Run the generator:
```bash
./generate-pages.sh
```

3. Update `index.html` to add the new app card

4. Deploy

## Deployment

### Option 1: GitHub Pages (Recommended)

1. Create a repo (e.g., `kellyclaudeai/app-support`)
2. Push this directory to the repo
3. Enable GitHub Pages in Settings → Pages → Source: main branch
4. Your site will be at: `https://kellyclaudeai.github.io/app-support/`

### Option 2: Netlify

1. Connect your GitHub repo to Netlify
2. Deploy from the `support-site` directory
3. Set up custom domain if desired

### Option 3: Custom Domain

1. Deploy to any static hosting (Vercel, Cloudflare Pages, etc.)
2. Point your domain (e.g., `support.kellyclaudeai.com`)

## URLs for App Store Connect

After deployment, use these URL patterns:

| App | Support URL | Privacy URL |
|-----|-------------|-------------|
| FocusedFasting | `{BASE}/apps/focusedfasting/support.html` | `{BASE}/apps/focusedfasting/privacy.html` |
| ParkPin | `{BASE}/apps/parkpin/support.html` | `{BASE}/apps/parkpin/privacy.html` |
| SubWatcher | `{BASE}/apps/subwatcher/support.html` | `{BASE}/apps/subwatcher/privacy.html` |
| HydroTrack | `{BASE}/apps/hydrotrack/support.html` | `{BASE}/apps/hydrotrack/privacy.html` |
| WarrantyVault | `{BASE}/apps/warrantyvault/support.html` | `{BASE}/apps/warrantyvault/privacy.html` |
| ParkMark | `{BASE}/apps/parkmark/support.html` | `{BASE}/apps/parkmark/privacy.html` |
| RecipeSnap | `{BASE}/apps/recipesnap/support.html` | `{BASE}/apps/recipesnap/privacy.html` |
| MuscleMatch | `{BASE}/apps/musclematch/support.html` | `{BASE}/apps/musclematch/privacy.html` |
| Looksmaxxing | `{BASE}/apps/looksmaxxing/support.html` | `{BASE}/apps/looksmaxxing/privacy.html` |

Replace `{BASE}` with your actual domain.

## Factory Integration

This is automatically part of the factory workflow:

1. When creating a new app, add it to `apps.json`
2. Run `./generate-pages.sh`
3. Commit and push to deploy
4. Use generated URLs in App Store Connect submission

## Customization

### Templates

Edit files in `templates/` to change the design or structure of all pages.

### Per-App Customization

Use these fields in `apps.json`:

- `custom_data_collection` - Additional data collection items for privacy policy
- `third_party_section` - Additional third-party service disclosure
- `custom_faq` - Extra FAQ items for support page
- `custom_disclaimer` - Additional disclaimers for terms page

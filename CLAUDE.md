# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a static marketing website for Gargantua Group, a technology consulting firm specializing in data processing, machine learning, and generative AI. The site is built with pure HTML, CSS (via Tailwind CDN), and vanilla JavaScript with no build process or package manager.

## Architecture

### Site Structure

The website follows a simple flat HTML architecture:

- **Main Pages** (root level):
  - `index.html` - Homepage with hero, team section, services overview, success stories, and CTA
  - `services.html` - Services overview page
  - `contact.html` - Contact form page
  - `privacy.html` - Privacy policy
  - `terms.html` - Terms of service

- **Team Profiles** (`team/`):
  - Individual HTML pages for each team member (e.g., `nick-kim.html`, `edward-jones.html`)
  - Each profile includes a photo, title, and biography
  - Team images are stored in `images/team/` with responsive variants (`-400w.jpg`, `-800w.jpg`)

- **Service Detail Pages** (`services/`):
  - `data-mastery.html` - Data Ontology Design service
  - `cognitive-system.html` - Cognitive System Engineering service
  - `ecosystem-architecture.html` - Ecosystem Architecture service

- **Source Archive** (`source_gargantua/`):
  - Contains older/backup versions of site files
  - Not part of the active site structure

### Design System

**Styling Approach:**
- Uses Tailwind CSS via CDN (`https://cdn.tailwindcss.com`)
- No build process or configuration files
- Custom CSS animations and effects defined inline in `<style>` blocks
- Primary color scheme: Dark backgrounds (`#0d1117`, `#000`), white text, glass-morphism effects

**Typography:**
- Primary: SF Pro Text and SF Pro Display (Apple system fonts as fallback)
- Multiple Google Fonts loaded dynamically via inline `<link>` tags
- Font classes follow pattern: `.font-{name}` (e.g., `.font-geist`, `.font-roboto`)

**Visual Effects:**
- Glass-morphism navigation: `.glass-effect` class with backdrop blur
- Animation classes: `.fade-in`, `.slide-up`, `.blur-in` with stagger delays (`.stagger-1` through `.stagger-6`)
- Hover effects on cards: `.success-card`, `.team-card`, `.interactive-cta` with transform and shadow transitions
- Team images use `.team-image` class with `object-position: center 50%` for consistent framing

**Icons:**
- Lucide icons loaded via CDN (`https://unpkg.com/lucide@latest`)
- Icons initialized with `data-lucide` attributes

### Navigation Pattern

All pages share a consistent navigation structure:
- Fixed header with glass effect (`fixed top-4 left-4 right-4 z-50`)
- Rounded pill-shaped nav bar with logo, links, and CTA button
- Links to: Home, Team, Services, Contact
- Responsive: Desktop nav hidden on mobile with hamburger menu button

### Images

**Organization:**
- `images/` - General site images
- `images/team/` - Team member photos with responsive variants
- `images/services/` - Service-related imagery

**Responsive Images:**
Team member photos use `srcset` for responsive loading:
```html
srcset="../images/team/nick-kim-400w.jpg 400w, ../images/team/nick-kim-800w.jpg 800w"
sizes="(max-width: 768px) 80vw, 480px"
```

### Analytics

All pages include Google Analytics tracking (ID: `G-8EXGD7W5GQ`):
```html
<script async src="https://www.googletagmanager.com/gtag/js?id=G-8EXGD7W5GQ"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-8EXGD7W5GQ');
</script>
```

## Development Workflow

### No Build Process

This is a static HTML site with no build system. Changes are made directly to HTML files.

### Testing Locally

Use any static file server to preview the site:
```bash
# Python 3
python3 -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000

# Node.js (if you have npx)
npx serve .
```

Then visit `http://localhost:8000`

### Deployment

The site is deployed as static files. To deploy changes:
1. Make edits to HTML files directly
2. Test locally using a static server
3. Commit changes to git
4. Push to hosting provider (files are served as-is)

### Git Workflow

Current branch: `main`
- Make changes directly on main or create feature branches
- Recent commits focus on team bio updates and analytics integration

## Common Editing Tasks

### Adding a New Team Member

1. Add team member photo to `images/team/`:
   - Full size image (e.g., `name.jpg`)
   - Create responsive variants: `name-400w.jpg`, `name-800w.jpg`

2. Create profile page in `team/`:
   - Copy an existing profile HTML (e.g., `team/nick-kim.html`)
   - Update name, title, photo path, and biography
   - Ensure proper image path (`../images/team/...`)

3. Add to team section in `index.html`:
   - Locate the team grid section
   - Add new card with photo, name, title, and link to profile

### Adding a New Service

1. Create service detail page in `services/`:
   - Copy existing service HTML (e.g., `services/data-mastery.html`)
   - Update title, description, and content

2. Add to services section:
   - Update `services.html` with new service card
   - Update service cards in `index.html` if needed

### Updating Styles

- All styles are inline in `<style>` blocks within each HTML file
- Common classes like `.glass-effect`, `.fade-in`, animation keyframes are defined per-page
- To change site-wide styles, update the `<style>` block in each relevant page
- No CSS compilation or preprocessing

### Content Updates

Text content is embedded directly in HTML. Edit the relevant HTML file to update:
- Headings, paragraphs, and body text
- Meta descriptions in `<head>` section
- Navigation labels
- Button text and links

## Key Considerations

### Consistency Across Pages

Since there's no templating system:
- Navigation structure must be manually kept consistent across all pages
- Style definitions (especially common ones like `.glass-effect`) should match across pages
- Google Analytics code must be present on all pages

### Performance Optimization

- Images should have responsive variants using `srcset`
- Use `loading="lazy"` and `decoding="async"` on images below the fold
- CDN resources (Tailwind, Lucide, fonts) are loaded from external sources

### Accessibility

- All images should have meaningful `alt` attributes
- Navigation links should be keyboard accessible
- Consider reduced motion preferences (some pages have `@media (prefers-reduced-motion)`)

### SEO

Each page should have:
- Unique `<title>` tag
- Descriptive meta description
- Proper heading hierarchy (h1, h2, h3)
- Open Graph and Twitter meta tags for social sharing

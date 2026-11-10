# Tali's Auto Repair — work checkpoint

**Last updated:** 9 Nov 2026 · **In production:** `21607bb` · **Live:** https://www.talisautorepair.com

---

## How this project ships

**`git push` does not deploy.** There is no Vercel git integration on this
project — production only moves when a CLI deploy runs:

```sh
./deploy.sh          # commit and push first
```

Linkage lives in `.vercel/project.json` (gitignored; recreate with `vercel link`).

**Never deploy from the MacBook Air copy** (`/Users/erickguzman/Desktop/talis-auto-repair`).
It still holds the pre-September version and would overwrite everything since.
The working copy is `~/Desktop/talis-auto-repair` on the Mac.

---

## Blocked — needs Erick

- [ ] **Send the unedited shop photos.** The gallery currently runs on the
      AI-edited versions, whose baked-in lettering is why the overlay captions
      had to be removed. Originals would let captions come back. Crop **3:2** or
      they get sliced at the edges.
- [ ] **Confirm which trust claims are true** — ASE certification, years in
      business, warranty terms, free estimates. Standard for the trade and cheap
      to add, but only the ones that are actually true.
- [ ] **Have Tali read the Spanish.** Grammar is sound; register is his call.
      It is Mexican / neutral Latin American (*mofles*, *balatas*, *refacciones*).
- [ ] **Add the Bash permission rule** to `~/.claude/settings.json` so Claude's
      production deploys stop being blocked at random:
      `"permissions": { "allow": ["Bash(/Users/erick/Desktop/talis-auto-repair/deploy.sh)"] }`

## Ready to build on request

- [ ] **Drone footage in the hero.** The `<video>` slot is already wired for
      `images/hero-video.mp4` / `.webm` — drop the files in and re-add two
      `<source>` tags at the marked comment. Nothing else changes. Budget
      $150–$500 for a local shoot; Google's Aerial View API is metered per view
      and forbids self-hosting the file, so it is the worse deal.
- [ ] **Trust-badge strip** — waits on the answers above.
- [ ] **Move Tailwind off the play CDN.** It ships a compiler to every visitor
      and causes a flash of unstyled content. Needs a build step, which changes
      how this project deploys.
- [ ] **Rest of the photos into the gallery** — 3:2, same as above.
- [ ] **Reconcile or delete the MacBook Air copy.** Harmless while nobody
      deploys from it.

---

## Traps

Things that are easy to get wrong here, each learned the hard way.

**`outputDirectory` is `"."`** — every file in the repo publishes to the live
domain unless `.vercelignore` lists it. Source art, the deploy script and
`.DS_Store` are excluded. After editing that file, confirm `favicon.png`,
`apple-touch-icon.png` and `images/*.webp` still return 200.

**`initLang()` must stay at the end of the script in `index.html`.** It touches
`lang` and `I18N`, both `let`/`const` in the same scope. Called earlier it throws
a temporal-dead-zone `ReferenceError` that silently kills every listener below
it — the page renders fine and nothing works.

**No `aggregateRating` schema for the Google reviews.** Google disallows
structured markup of reviews hosted on its own platform and can penalise it. The
5.0 is displayed visually and linked to the listing instead.
Place ID: `ChIJ2YaQEABTBogRD-cDQ3hDd5Y`.

**Review quotes stay verbatim** — never translated, never tidied. Erick's own
5-star review is deliberately kept off the testimonials; it is his uncle's shop.

**This repo is public** (`forgedigital-studio/talis-auto-repair`). Keep ids and
secrets out of anything committed. The remote still points at the old
`wiscofleetworks-cpu` URL and redirects.

**Booking validation is client-side only.** Formspree accepts any POST, so a
determined person can still submit a past date. Closing that needs a real
backend; deliberately skipped — the shop gets very few bookings through the site.

**No availability tracking.** The `get-booked-slots` endpoint 404s and was
removed; every slot is always offered and the shop confirms by phone. Two people
can request the same time.

**Site images are self-hosted now.** They used to load from Supabase project
`zgnpmogdjnnhpwewavnr`, which is not under Erick's account. Don't reintroduce it.

---

## Shipped 9 Nov 2026

| Commit | |
|---|---|
| `5dc8ad4` | mobile nav + sticky Call/Book bar, real Google reviews section, images self-hosted as WebP (13.8 MB → 663 KB), favicons, LocalBusiness JSON-LD |
| `1a1cb55` | booking confirmation switched to English |
| `23210cf` | bilingual EN/ES toggle |
| `422eda2` | gallery captions removed, cards re-proportioned to 3:2 |
| `a2b1735` | `deploy.sh`, gitignore `.vercel` and `.DS_Store` |
| `21607bb` | stop publishing source art and the deploy script |

Earlier: `5dc8ad4`'s parent `22bde11` hardened the appointment date validation
(past dates, clock skew, Sunday) and added the local-SEO basics.

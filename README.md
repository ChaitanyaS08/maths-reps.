# Maths Reps — Mobile-first PWA + optional cloud sync

## What this version includes
- Mobile-first responsive UI; installable PWA on Android and Windows browsers.
- Local-first question library and spaced-repetition review history.
- CSV import, JSON backup/restore, daily target, chapter progress.
- Optional Supabase email/password account for syncing one user's data between devices.
- Offline app shell after first successful online load; reviews are stored locally and can continue offline.

## Important sync behaviour
This first sync implementation stores one JSON snapshot per account. Use one device at a time while testing. If both devices are edited offline and later synced independently, the last uploaded snapshot can overwrite newer changes on the other device. Export backups before the first sync. The app prompts before replacing local data when it detects a newer cloud snapshot. It is not a conflict-free collaborative database yet.

The app does not automatically upload while offline; after reconnecting, open Sync setup and press **Sync now**. Local edits on a signed-in device schedule a best-effort sync, but keep pressing Sync now until the status says complete.

## Publish for phone + PC
PWA installation and service workers require HTTPS (or localhost). A local HTML file opened as `file://` cannot install as a PWA.

Easy free static hosting options include Netlify Drop or GitHub Pages:
1. Create a free hosting account.
2. Upload the contents of this folder as a static site (not the parent folder).
3. Open the resulting HTTPS URL on your Android phone in Chrome.
4. Use Chrome menu → **Add to Home screen** or **Install app** (wording differs).
5. Open the same URL on Windows Edge/Chrome and choose **Install app**.

## Enable syncing (one-time setup)
1. Create a Supabase project at https://supabase.com/.
2. In Supabase, open SQL Editor and run `supabase-schema.sql`.
3. In Project Settings → API, copy the Project URL and the publishable key (or legacy anon key). Never use a service-role/secret key in the app.
4. Open the hosted Maths Reps app, choose **Sync setup**, paste URL/key, and save.
5. Create an account with email/password and sign in.
6. Export a JSON backup before first sync. Press **Sync now** on the device whose data you want to keep as the initial cloud copy.
7. On the second device, open the same hosted URL, enter the same project URL/key, sign in to the same account, then press **Sync now**. If it asks to download the newer cloud copy, accept after confirming this is the expected data.

Supabase email confirmation settings may require clicking a confirmation email before signing in. Use a password you don't reuse elsewhere.

## Local development
Python 3:
- Windows: double-click `Start Maths Reps.bat`
- Or run: `python -m http.server 8080` in this folder and open http://localhost:8080

Note: for true PWA installation on phone, publish to HTTPS; localhost only works for development on the same computer.

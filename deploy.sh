#!/bin/sh
# Deploy this site to production.
#
# Vercel has NO git integration on this project, so `git push` does not ship —
# production only updates when this runs. Always commit and push first.
#
# Project linkage lives in .vercel/project.json (gitignored; recreate with
# `vercel link` if missing). Never deploy from the old MacBook Air copy.
set -e
cd "$(dirname "$0")"
exec vercel --prod --yes

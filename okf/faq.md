---
type: "FAQ"
title: "FAQ — PageAudit"
description: "Perguntas e respostas sobre o PageAudit, as mesmas publicadas na página."
resource: "https://pageaudit.online/"
---

# Perguntas frequentes — PageAudit

## What does an audit check?

Twenty-four technical checks on one public page: title, meta description, canonical, viewport, charset, lang, robots meta, Open Graph, X card, JSON-LD, H1, image alt, hreflang, deprecated markup, HTTP status, robots.txt, sitemap and redirects. Each finding has a stable code and a severity, and the score from 0 to 100 is computed from them.

## Does it use AI?

No. The checks are deterministic and the fixes are derived from what the page already declares, so the same page gets the same result every time. Placeholders such as {{DESCRICAO}} mark what only you can write.

## What is the patch?

The fixes of an audit consolidated by target: head tags in order, plus robots.txt and sitemap when they are missing. Paste the head block into the template, fill the placeholders, audit again. It is also available by API at /api/audits/:id/patch.

## What is free and what costs?

Ten audits a day per IP, twenty saved tabs and every single-check tool are free, with no sign-up. Agents beyond the daily ten pay US$ 0.02 per audit and an extra saved tab costs US$ 0.05, per request (x402) or from prepaid credit — the price comes in the HTTP 402 before any charge. In the browser, the Turnstile checkbox unlocks more audits without paying.

## What is the 90-day trial?

Sign in with your email and confirm the code that arrives: for 90 days there is no paywall on audits and tabs, and your tabs follow you to any device. No card, no plan.

## Do I need an account?

No. Audits run without one, and tabs are kept for this browser. An account only adds the trial and syncs the tabs across devices; agents pay per request instead.

## Can I use it from an agent?

Yes: POST /api/audit with the URL returns the findings and the fixes as JSON, the MCP server exposes the same calls, and every resource carries its own API links. The 402 brings both doors, x402 or prepaid credit.

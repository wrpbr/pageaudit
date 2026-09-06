---
type: "API"
title: "API do PageAudit"
description: "Superfície HTTP e MCP do PageAudit, com o modelo de cobrança."
resource: "https://pageaudit.online/api/"
---

# API do PageAudit

Base: https://pageaudit.online

## Como pagar

Auditoria one-shot é grátis. As rotas pagas cobram por requisição (x402) ou descontam de crédito pré-pago (`POST /api/credito?usd=10`).

## Endpoints

* `GET /okf/:arquivo` — OKF bundle (Open Knowledge Format v0.1): markdown with frontmatter so an agent reads the whole product without parsing HTML.
* `GET /.well-known/:arquivo` — Machine discovery before the home page: `api-catalog` (RFC 9727, a linkset with the API and the MCP), `security.txt` (RFC 9116) and `mcp-registry-auth` (the official MCP registry key).
* `GET /apis.json` — APIs.json (apisjson.org, 0.19): the index APIs.io harvests — the API, the MCP, OpenAPI, guide and OKF bundle in one file. Also at `/.well-known/apis.json`.
* `GET /api/` — Self-describing index: the whole API surface, with quota and retention policy.
* `GET /api/health` — Liveness and the commit deployed right now — it is how the smoke waits for its own deploy.
* `POST /mcp` — MCP server over HTTP (Streamable HTTP, JSON-RPC 2.0) — plugs into the client with nothing to install.
* `POST /api/audit` — Audits a URL and returns the full report in one call, without a token or a tab.
* `GET /api/audits/:id` — Re-reads an audit already made, in full, without re-auditing the page.
* `GET /api/audits/:id/patch` — The consolidated patch of an audit: the <head> block ready to paste, the files to create at the root and the templates for what only the owner can fill in — no model, only facts from the page itself.
* `GET /api/tools` — The micro-tools: one landing per check, all driven by the same engine as the audit.
* `GET /api/tools/:slug` — Metadata and copy of one micro-tool.
* `GET /tools` — HTML hub of the micro-tools, indexable. For JSON use `GET /api/tools`.
* `GET /tools/:slug` — HTML landing of one check, indexable. An unknown slug returns a real 404.
* `POST /api/audits/:id/share` — Publishes the audit under a non-enumerable slug. Calling again returns the same slug.
* `DELETE /api/audits/:id/share` — Revokes the share; the slug stops serving the report.
* `GET /api/shared/:slug` — Shared report as JSON, without credentials — the machine twin of `/r/:slug`.
* `GET /r/:slug` — HTML page of the shared report, with `noindex`.
* `GET /api/badge/:slug` — Metadata of the score badge, including the markdown ready for the README.
* `GET /badge/:slug.svg` — SVG score badge, to paste in the README of the audited project.
* `POST /api/guest` — Creates a guest `pa_…` — it is what gives access to the tab workspace without an account.
* `GET /api/tabs` — The owner's whole workspace, with the active tab's result already rehydrated.
* `POST /api/tabs` — Opens a tab for the URL, or focuses the one that already exists for it.
* `GET /api/tabs/:id` — One tab with the full report of its last run.
* `PATCH /api/tabs/:id` — Renames the tab or puts it in focus.
* `DELETE /api/tabs/:id` — Closes the tab. Its audit history keeps existing.
* `POST /api/tabs/:id/run` — Re-audits the tab's URL and stores a new report.
* `GET /api/gate` — How many free audits remain for this IP and whether Turnstile is about to be required.
* `GET /api/billing` — Tab allowance, prices, full x402 configuration and the state of the trial.
* `GET /api/me` — The session's account, its last 50 audits and the state of the trial.
* `POST /api/auth/start` — Sends the 6-digit code by e-mail to create the account or sign in to it.
* `POST /api/auth/verify` — Exchanges the code for a session — and confirming the e-mail grants the trial on the spot.
* `POST /api/auth/claim` — Moves the guest's audits and tabs to the signed-in account.
* `POST /api/auth/logout` — Invalidates the current session.
* `POST /api/contact` — Talks to support: a human solves Turnstile, an agent pays $0.10 in x402.
* `POST /api/visit` — Ping from the interface that increments the day's visits. Agents need not call it.
* `GET /api/metrics` — Metrics of the last 7 days and the most frequent findings across audits. With the operator token, includes payments.
* `POST /api/credito` — Top up prepaid credit: pay once with x402 and get the token that debits on any API of the house.
* `GET /api/credito` — Credit balance and statement — the latest movements, without returning the token.

Catálogo completo: https://pageaudit.online/llms-full.txt · OpenAPI: https://pageaudit.online/openapi.json

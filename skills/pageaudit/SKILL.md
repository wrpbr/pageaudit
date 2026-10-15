---
name: pageaudit
description: Audit a web page's technical SEO with PageAudit (pageaudit.online) and get the fix. Check title, meta description, canonical, robots and sitemap, Open Graph, headings, structured data (JSON-LD), security headers and page delivery, with evidence and a ready patch for each finding. Compare a deploy preview with production by finding code, keep pages in tabs with history and a daily watch, and run a Lighthouse lab test. Use when a task mentions SEO, meta tags, Open Graph, JSON-LD, schema.org, canonical, robots.txt, a site audit, a page that dropped from search, or checking a preview deploy.
license: MIT-0
compatibility: Needs HTTPS access to pageaudit.online. Works with the remote MCP server or with plain HTTP calls.
---

# PageAudit

PageAudit fetches a public page, reads what search engines and link previews read, and reports each problem with
its evidence and a suggested change. The report does not certify security or accessibility.

## Connect

- MCP server (preferred): `https://pageaudit.online/mcp?checkout=site`. Transport: Streamable HTTP. Every MCP tool is
  free, within its free limits: no payment.
- HTTP API: base URL `https://pageaudit.online`. Each MCP tool calls one route of this API.
- Identity: `create_guest` returns a guest token `pa_…`. Send it as `guest_token` (or `X-Guest-Token`) so the
  audits are tied to it and can be read again and compared.
- Discovery: `GET https://pageaudit.online/api/` lists the routes, prices and limits.
  `https://pageaudit.online/llms-full.txt` has the full reference.

## MCP tools

| Tool | HTTP | Use it to |
|---|---|---|
| `audit_url` | `POST /api/audit` | Audit a URL in one call. With `compare_with` (an earlier audit ID of the same owner), get `comparison`: findings that appeared and disappeared, the score delta and `regression`. |
| `get_audit` | `GET /api/audits/{id}` | Read an audit again, with the ready fix of each finding. No new fetch, no allowance used. |
| `get_patch` | `GET /api/audits/{id}/patch` | Get the consolidated patch: `<head>` block, files to create and templates. |
| `create_guest` | `POST /api/guest` | Get the guest token that owns tabs and audits. |
| `create_tab` | `POST /api/tabs` | Save a page. Set `queue_audit:false` for monitoring without a page audit. |
| `list_tabs` | `GET /api/tabs` | List the saved pages and the latest report. |
| `run_tab` | `POST /api/tabs/{id}/run` | Audit a saved page again. |
| `tab_history` | `GET /api/tabs/{id}/history` | Read the earlier runs and what changed between them. |
| `watch_tab` | `PATCH /api/tabs/{id}` | Turn the daily watch on or off (needs an account). |
| `domain_status` / `check_domain` | `GET/POST /api/tabs/{id}/domain` | Read or refresh registration, contacts, TLS, DNS, CAA, mail policies, certificate issuance and a limited server comparison. |
| `configure_domain_monitor` | `PUT /api/tabs/{id}/domain/monitor` | Enable or stop monitoring with current rights and revision. |
| `domain_history` | `GET /api/tabs/{id}/domain/history` | Read private events and notice delivery. |
| `acknowledge_domain_event` | `POST /api/tabs/{id}/domain/history/{number}/ack` | Mark an expected event without erasing evidence. |
| `domain_portfolio` | `POST /api/tabs/domain-portfolio` | Read summaries for selected pages in the active organization. |
| `preview_domain_alerts` / `apply_domain_alerts` | `POST/PATCH /api/tabs/domain-portfolio/alerts` | Review and apply renewal notices for selected domains. |
| `review_connection` / `connection_review` / `cancel_connection_review` | `POST/GET/DELETE /api/tabs/{id}/domain/tls` | Start, read or cancel a bounded TLS review. |
| `lab_test` | `POST /api/audits/{id}/lab` | Start a Lighthouse test through Google PageSpeed Insights. |
| `lab_result` | `GET /api/audits/{id}/lab` | Read the lab scores and metrics when the test ends. |
| `list_tools` | `GET /api/tools` | List the single-check tools (title, meta, canonical, Open Graph, JSON-LD…). |

## Rules

1. If an MCP tool answers `free_limit`, tell the user that the free limit for that action is used up. Do not use an
   allowance from memory; on the HTTP API, `GET /api/billing` reads the free allowances.
2. Never pay by yourself. On the HTTP API, a paid route returns HTTP 402: show the price and
   https://pageaudit.online/pricing to the user. The person buys on the site.
3. To compare a preview with production: audit production with a guest token, then audit the preview with the same
   token and `compare_with` set to the production audit ID. Report `comparison.broke` first.
4. A finding is identified by its `code`. The message carries the measured value and changes between runs.
5. HTTP 502 with `target_blocked` or `target_rate_limited` means the site's firewall answered, not the page.
   Nothing was audited; show `blocked.fix` to the user.
6. If you get HTTP 429 or 503, wait for the time in `Retry-After` and try once more.

## Examples

```bash
# One audit, no token
curl -s -XPOST https://pageaudit.online/api/audit -H 'content-type: application/json' \
  -d '{"url":"https://example.com/"}'

# Preview against production, same guest token
PA=$(curl -s -XPOST https://pageaudit.online/api/guest | jq -r .token)
PROD=$(curl -s -XPOST https://pageaudit.online/api/audit -H 'content-type: application/json' \
  -d "{\"url\":\"https://example.com/\",\"guest_token\":\"$PA\"}" | jq -r .id)
curl -s -XPOST https://pageaudit.online/api/audit -H 'content-type: application/json' \
  -d "{\"url\":\"https://preview.example.com/\",\"guest_token\":\"$PA\",\"compare_with\":\"$PROD\"}" | jq .comparison
```

## Limits

- PageAudit reads the HTML the server sends (up to 2 MB) and does not run the page's JavaScript.
- Domain settings, contacts and history require the account session and current organization.
  Writes require CSRF. A stale revision or portfolio preview changes nothing.
- Certificate issuance uses a 30-day lookup by primary domain, with explicit collection gaps.
  Issuance does not prove installation. A discovered name never activates monitoring or billing by itself.
- The server comparison samples two DNS servers and one address of each IP family.
  Other CDN locations are outside this sample. Contact history exposes field changes, never personal values.
- TLS reviews use testssl.sh 3.2.4 with a 170-second limit and at most three starts per account per UTC day.
  Reports expire after 26 hours. Partial results do not establish safety.
- Terms: https://pageaudit.online/terms. Privacy: https://pageaudit.online/privacy. Contact: contato@pageaudit.online.

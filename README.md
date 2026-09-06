# PageAudit

> Technical SEO audit that ships the fix. Built for people and agents who build sites.

**Live:** https://pageaudit.online · **API index:** https://pageaudit.online/api/ · **OpenAPI:** https://pageaudit.online/openapi.json · **MCP server:** https://pageaudit.online/mcp · **Docs for agents:** https://pageaudit.online/llms.txt

## What it does

PageAudit fetches a URL like a crawler and runs 24 deterministic checks — title, meta description, canonical, headings, Open Graph, Twitter cards, JSON-LD, hreflang, images, links, redirects, robots.txt, sitemap — with no LLM in the loop. Each finding comes with the value found, why it matters and how to fix it; the patch endpoint returns the corrected `<head>` plus robots.txt and sitemap.xml as files.

Audits live in tabs you can reopen, share and badge (an SVG score badge for the README of the audited project). Twenty free single-check tools — title, H1, hreflang, links, HTTP status, redirects, robots.txt, Open Graph and more — run the same engine at https://pageaudit.online/tools.

## Quickstart (no account)

Audit a page in one call (no token, no account):

```bash
curl -s -X POST https://pageaudit.online/api/audit -H 'content-type: application/json' -d '{"url":"https://example.com"}'
```

List the single-check tools:

```bash
curl -s https://pageaudit.online/api/tools
```

Self-described API index:

```bash
curl -s https://pageaudit.online/api/
```

## MCP server (remote, nothing to install)

Streamable HTTP over the same public API. Every tool is a call on this API; `operationId` in the OpenAPI is the tool name. Server card: `GET https://pageaudit.online/mcp`.

Claude Code:

```bash
claude mcp add --transport http pageaudit https://pageaudit.online/mcp
```

Cursor (`.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "pageaudit": {
      "url": "https://pageaudit.online/mcp"
    }
  }
}
```

Main tools: `audit_url`, `get_audit`, `get_patch`, `list_tools`, `get_tool`, `get_badge`, `create_guest`, `list_tabs`, `create_tab`, `run_tab`.

## Pricing

**Free.** Ten audits a day, twenty saved tabs and every single-check tool, without an account. Confirm an e-mail and get 90 days without limits.

**Paid.** Beyond the free allowance, an agent pays US$ 0.02 per audit and US$ 0.05 per extra saved tab, per request (x402: the server answers HTTP 402 with the payment terms) or from prepaid credit.

## What it is not

It does not crawl your whole site, it does not measure rankings, and it does not guess: every check is a rule you can read on the tool's page.

## Files in this repository

| | |
|---|---|
| `README.md` | this page |
| `openapi.json` | OpenAPI 3 document; `operationId` = MCP tool name |
| `llms.txt` | short guide for agents (endpoints, auth, pricing, MCP) |
| `llms-full.txt` | full reference: params, body, response field by field, errors (when published) |
| `apis.json` | APIs.json index (APIs.io) |
| `mcp/server.json` | manifest published in the Official MCP Registry (`online.pageaudit/pageaudit`) |
| `okf/` | OKF bundle: markdown with front-matter (index, about, API, FAQ) |
| `examples/` | `curl.sh` and `python.py` with the free calls above |

## About this repository

This repository mirrors the public, machine-readable surfaces of PageAudit as served at https://pageaudit.online: the OpenAPI document, the `llms.txt` guide, the MCP registry manifest, the OKF bundle and the APIs.json index. The product itself is not open source; the mirror exists so the API and the MCP server can be found, read and linked from here. Files are regenerated from the live surfaces (last sync: 2026-09-05); if something here disagrees with the site, the site is right.

Issues and suggestions are welcome here. Contact: contato@pageaudit.online. Author: Wendel ([@wrpbr](https://github.com/wrpbr)).

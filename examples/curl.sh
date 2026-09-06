#!/usr/bin/env bash
# PageAudit — free calls, no account. 
set -euo pipefail

# Audit a page in one call (no token, no account)
curl -s -X POST https://pageaudit.online/api/audit -H 'content-type: application/json' -d '{"url":"https://example.com"}'

# List the single-check tools
curl -s https://pageaudit.online/api/tools

# Self-described API index
curl -s https://pageaudit.online/api/

import requests

r = requests.post("https://pageaudit.online/api/audit", json={"url": "https://example.com"}, timeout=60)
r.raise_for_status()
report = r.json()
print(sorted(report.keys()))

{{/*
NetworkPolicy egress DNS rules
*/}}
{{- define "ollama.networkPolicy.egress.dns" }}
{{- if .Values.networkPolicy.egress.allowDNS }}
  # DNS resolution - RESTRICTED to cluster DNS pods only (prevents DNS tunneling attacks)
  # SECURITY: Only allows DNS queries to cluster-managed DNS pods (kube-dns/coredns)
  # This prevents DNS tunneling attacks where attackers use DNS queries to exfiltrate data
  # or establish command & control channels to external malicious DNS servers.
  # All DNS traffic is restricted to the cluster's DNS service, which then handles
  # legitimate external DNS resolution through the cluster's DNS infrastructure.
  {{- include "ollama.networkPolicy.dnsRule" (dict "dnsApp" "kube-dns" "context" .) | nindent 2 }}
  # Also allow DNS via CoreDNS (for clusters using CoreDNS instead of kube-dns)
  {{- include "ollama.networkPolicy.dnsRule" (dict "dnsApp" "coredns" "context" .) | nindent 2 }}
{{- end }}
{{- end }}


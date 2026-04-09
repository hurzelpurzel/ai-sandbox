{{/*
NetworkPolicy DNS rule helper - creates a DNS egress rule for a specific DNS service
Usage: {{- include "ollama.networkPolicy.dnsRule" (dict "dnsApp" "kube-dns" "context" .) }}
*/}}
{{- define "ollama.networkPolicy.dnsRule" }}
- to:
    - namespaceSelector:
        matchLabels:
          {{- if $.context.Values.networkPolicy.egress.dnsNamespace }}
          kubernetes.io/metadata.name: {{ $.context.Values.networkPolicy.egress.dnsNamespace }}
          {{- else }}
          kubernetes.io/metadata.name: kube-system
          {{- end }}
      podSelector:
        matchLabels:
          k8s-app: {{ $.dnsApp }}
  ports:
    - protocol: UDP
      port: 53
    - protocol: TCP
      port: 53
{{- end }}


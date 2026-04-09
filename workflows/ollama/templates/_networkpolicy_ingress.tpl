{{/*
NetworkPolicy ingress rules
*/}}
{{- define "ollama.networkPolicy.ingress" }}
ingress:
  # Allow health probes from kubelet
  # Health probes come from the node's kubelet, which typically requires allowing
  # the kube-system namespace or all namespaces. We use kube-system for better security.
  - ports:
      - protocol: TCP
        port: {{ .Values.ollama.port }}
    from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: kube-system
  # Application ingress rules
  {{- if .Values.networkPolicy.ingress.enabled }}
  - ports:
      - protocol: TCP
        port: {{ .Values.ollama.port }}
    {{- if .Values.networkPolicy.ingress.from }}
    # Use configured restrictions (namespaceSelector/podSelector)
    from:
      {{- toYaml .Values.networkPolicy.ingress.from | nindent 6 }}
    {{- else }}
    # No restrictions configured - allowing all namespaces. Set ingress.from to restrict.
    from:
      - namespaceSelector: {}
    {{- end }}
  {{- end }}
{{- end }}


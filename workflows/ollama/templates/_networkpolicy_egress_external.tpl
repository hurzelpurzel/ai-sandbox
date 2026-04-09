{{/*
NetworkPolicy egress external IP rules
*/}}
{{- define "ollama.networkPolicy.egress.external" }}
  # Allow egress to external IPs (internet) but block private ranges
  # This allows connections to public IPs while blocking cluster-internal communication
  - to:
      - ipBlock:
          cidr: 0.0.0.0/0
          except:
            # Block RFC 1918 private ranges
            - 10.0.0.0/8
            - 172.16.0.0/12
            - 192.168.0.0/16
            # Block CGNAT range (100.64.0.0/10)
            - 100.64.0.0/10
            # Block link-local ranges
            - 169.254.0.0/16
            # Block multicast
            - 224.0.0.0/4
            # Block cluster service CIDR (if configured)
            {{- if .Values.networkPolicy.egress.blockClusterCIDR }}
            {{- if .Values.networkPolicy.egress.clusterCIDR }}
            - {{ .Values.networkPolicy.egress.clusterCIDR }}
            {{- end }}
            {{- end }}
    ports:
      {{- if .Values.networkPolicy.egress.allowedPorts }}
      {{- range .Values.networkPolicy.egress.allowedPorts }}
      - protocol: {{ .protocol | default "TCP" }}
        port: {{ .port }}
      {{- end }}
      {{- else }}
      # Force-deny all egress by default except DNS + HTTPS for maximum security
      - protocol: TCP
        port: 443
      {{- end }}
  {{- if .Values.networkPolicy.egress.additionalRules }}
  {{- toYaml .Values.networkPolicy.egress.additionalRules | nindent 2 }}
  {{- end }}
{{- end }}


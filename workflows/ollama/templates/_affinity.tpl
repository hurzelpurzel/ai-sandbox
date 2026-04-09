{{/*
Pod affinity and anti-affinity configuration
*/}}
{{- define "ollama.affinity" }}
{{- if or .Values.affinity .Values.podAntiAffinity.enabled }}
affinity:
  {{- if .Values.affinity }}
  {{- toYaml .Values.affinity | nindent 2 }}
  {{- end }}
  {{- if .Values.podAntiAffinity.enabled }}
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              {{- include "ollama.selectorLabels" . | nindent 14 }}
          topologyKey: "kubernetes.io/hostname"
  {{- end }}
{{- end }}
{{- end }}


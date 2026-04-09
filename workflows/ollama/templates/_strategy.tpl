{{/*
Deployment strategy configuration
*/}}
{{- define "ollama.strategy" }}
{{- if .Values.strategy.type }}
strategy:
  type: {{ .Values.strategy.type | quote }}
  {{- if and (eq .Values.strategy.type "RollingUpdate") .Values.strategy.rollingUpdate }}
  rollingUpdate:
    {{- toYaml .Values.strategy.rollingUpdate | nindent 4 }}
  {{- end }}
{{- else if .Values.persistence.enabled }}
strategy:
  type: Recreate
{{- end }}
{{- end }}


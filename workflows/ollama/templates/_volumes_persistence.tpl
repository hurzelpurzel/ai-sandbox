{{/*
Persistence-related volumes (model-storage, quant-models)
Falls back to emptyDir when persistence is disabled
*/}}
{{- define "ollama.volumes.persistence" }}
{{- if .Values.persistence.enabled }}
- name: model-storage
  persistentVolumeClaim:
    claimName: {{ if .Values.persistence.existingClaim }}{{ .Values.persistence.existingClaim }}{{ else if .Values.persistence.name }}{{ .Values.persistence.name }}{{ else }}{{ include "ollama.fullname" . }}-models{{ end }}
{{- else }}
# Fallback to emptyDir when persistence is disabled (ephemeral, data lost on pod restart)
- name: model-storage
  emptyDir: {}
{{- end }}
{{- if .Values.ollama.quantization }}
{{- if .Values.ollama.quantization.enabled }}
{{- if or (eq .Values.ollama.quantization.type "gguf") (eq .Values.ollama.quantization.type "gptq") (eq .Values.ollama.quantization.type "awq") }}
{{- if .Values.persistence.enabled }}
- name: quant-models
  persistentVolumeClaim:
    claimName: {{ if .Values.persistence.existingClaim }}{{ .Values.persistence.existingClaim }}{{ else if .Values.persistence.name }}{{ .Values.persistence.name }}{{ else }}{{ include "ollama.fullname" . }}-models{{ end }}
{{- else }}
- name: quant-models
  emptyDir: {}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}


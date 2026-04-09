{{/*
Container ports configuration
Ollama default port is 11434
*/}}
{{- define "ollama.ports" }}
- name: http
  containerPort: {{ .Values.ollama.port | default 11434 }}
  protocol: TCP
{{- end }}


{{/*
Health probes for the Ollama container
Composed from individual probe templates
*/}}
{{- define "ollama.probes" }}
{{- include "ollama.probe.startup" . }}
{{- include "ollama.probe.liveness" . }}
{{- include "ollama.probe.readiness" . }}
{{- end }}

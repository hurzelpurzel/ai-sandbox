{{/*
Volume mounts for the OLLAMA container
Composed from core, persistence, SSH keys, and extra volume mount templates
*/}}
{{- define "ollama.volumeMounts" }}
{{- include "ollama.volumeMounts.core" . }}
{{- include "ollama.volumeMounts.persistence" . }}
{{- include "ollama.volumeMounts.ssh" . }}
{{- include "ollama.volumeMounts.derivedModels" . }}
{{- include "ollama.volumeMounts.extra" . }}
{{- end }}

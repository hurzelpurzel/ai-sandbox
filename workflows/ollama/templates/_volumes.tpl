{{/*
Volumes for the pod
Composed from core, persistence, SSH keys, and extra volume templates
*/}}
{{- define "ollama.volumes" }}
{{- include "ollama.volumes.core" . }}
{{- include "ollama.volumes.persistence" . }}
{{- include "ollama.volumes.ssh" . }}
{{- include "ollama.volumes.derivedModels" . }}
{{- include "ollama.volumes.extra" . }}
{{- end }}

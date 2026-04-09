{{/*
Environment variables for the Ollama container
Composed from multiple sub-templates for better organization
*/}}
{{- define "ollama.env" }}
{{- include "ollama.env.basic" . }}
{{- include "ollama.env.persistence" . }}
{{- include "ollama.env.cache" . }}
{{- include "ollama.env.hfToken" . }}
{{- include "ollama.env.hfTimeouts" . }}
{{- include "ollama.env.cloud" . }}
{{- include "ollama.env.modelsSync" . }}
{{- include "ollama.env.derivedModels" . }}
{{- include "ollama.env.ollama" . }}
{{- include "ollama.env.user" . }}
{{- end -}}


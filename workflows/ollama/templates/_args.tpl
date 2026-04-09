{{/*
Command line arguments for ollama serve
Ollama uses 'ollama serve' command with minimal CLI flags
All configuration is done via environment variables
Additional arguments can be appended for custom behavior
*/}}
{{- define "ollama.args" }}
            - "serve"
{{- if .Values.ollama.additionalArgs }}
{{- range .Values.ollama.additionalArgs }}
            - {{ . | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Backend arguments with blacklist support
*/}}
{{- define "ollama.args.backend" }}
            {{- if .Values.ollama.backend }}
            {{- $backend := .Values.ollama.backend }}
            {{- $blacklisted := false }}
            {{- if .Values.ollama.backendBlacklist }}
            {{- range .Values.ollama.backendBlacklist }}
            {{- if eq $backend . }}
            {{- $blacklisted = true }}
            {{- end }}
            {{- end }}
            {{- end }}
            {{- if and (ne $backend "cuda") (not $blacklisted) }}
            - "--backend"
            - {{ $backend | quote }}
            {{- end }}
            {{- end }}
{{- end }}


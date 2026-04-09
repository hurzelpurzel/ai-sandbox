{{/*
Basic Ollama environment variables
Ollama uses OLLAMA_HOST for host/port configuration (default: 127.0.0.1:11434)
*/}}
{{- define "ollama.env.basic" }}
            - name: PYTHONUNBUFFERED
              value: "1"
            - name: PYTHONDONTWRITEBYTECODE
              value: "1"
            # GIN_MODE - GIN framework mode (debug or release)
            # For production, it is recommended to set this to "release" to reduce log verbosity
            # Default is "debug" which shows detailed GIN framework logs
            - name: GIN_MODE
              value: {{ .Values.ollama.ginMode | default "debug" | quote }}
{{- if not .Values.ollama.host }}
            # OLLAMA_HOST defaults to 0.0.0.0:11434 for Kubernetes (bind to all interfaces)
            - name: OLLAMA_HOST
              value: "0.0.0.0:{{ .Values.ollama.port | default 11434 }}"
{{- end }}
{{- end }}



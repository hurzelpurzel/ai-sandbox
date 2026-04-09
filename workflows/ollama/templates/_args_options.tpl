{{/*
Top-level options for ollama serve
*/}}
{{- define "ollama.args.options" }}
{{- if .Values.ollama.options }}
{{- if .Values.ollama.options.aggregateEngineLogging }}
            - "--aggregate-engine-logging"
{{- end }}
{{- if .Values.ollama.options.apiServerCount }}
            - "--api-server-count"
            - {{ .Values.ollama.options.apiServerCount | int | quote }}
{{- end }}
{{- if .Values.ollama.options.config }}
            - "--config"
            - {{ .Values.ollama.options.config | quote }}
{{- end }}
{{- if ne .Values.ollama.options.disableLogRequests nil }}
            {{- if .Values.ollama.options.disableLogRequests }}
            - "--disable-log-requests"
            {{- else }}
            - "--no-disable-log-requests"
            {{- end }}
{{- end }}
{{- if .Values.ollama.options.disableLogStats }}
            - "--disable-log-stats"
{{- end }}
{{- if ne .Values.ollama.options.enableLogRequests nil }}
            {{- if .Values.ollama.options.enableLogRequests }}
            - "--enable-log-requests"
            {{- else }}
            - "--no-enable-log-requests"
            {{- end }}
{{- end }}
{{- if .Values.ollama.options.headless }}
            - "--headless"
{{- end }}
{{- end }}
{{- end }}


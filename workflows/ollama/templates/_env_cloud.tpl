{{/*
Ollama Cloud environment variables
Supports optional API key injection and explicit cloud disable mode.
*/}}
{{- define "ollama.env.cloud" }}
{{- $apiKeySet := false }}
{{- $noCloudSet := false }}
{{- range .Values.ollama.env }}
{{- if eq .name "OLLAMA_API_KEY" }}{{- $apiKeySet = true }}{{- end }}
{{- if eq .name "OLLAMA_NO_CLOUD" }}{{- $noCloudSet = true }}{{- end }}
{{- end }}
{{- if and .Values.ollama.cloud.apiKey (not $apiKeySet) }}
            - name: OLLAMA_API_KEY
              value: {{ .Values.ollama.cloud.apiKey | quote }}
{{- else if and .Values.ollama.cloud.apiKeySecret.name .Values.ollama.cloud.apiKeySecret.key (not $apiKeySet) }}
            - name: OLLAMA_API_KEY
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.ollama.cloud.apiKeySecret.name | quote }}
                  key: {{ .Values.ollama.cloud.apiKeySecret.key | quote }}
{{- end }}
{{- if and .Values.ollama.cloud.disable (not $noCloudSet) }}
            - name: OLLAMA_NO_CLOUD
              value: "1"
{{- end }}
{{- end }}

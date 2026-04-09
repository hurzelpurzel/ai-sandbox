{{/*
HuggingFace Token Configuration
PREFERRED: Use credentials from Kubernetes secret (recommended for production)
ALTERNATIVE: Use direct token value (not recommended for production)
*/}}
{{- define "ollama.env.hfToken" }}
{{- if .Values.ollama.hfToken }}
{{- if .Values.ollama.hfToken.credentials.secretName }}
            - name: HF_TOKEN
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.ollama.hfToken.credentials.secretName | quote }}
                  key: {{ .Values.ollama.hfToken.credentials.key | default "token" | quote }}
            # Compatibility: many HF clients prefer HUGGINGFACE_HUB_TOKEN
            - name: HUGGINGFACE_HUB_TOKEN
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.ollama.hfToken.credentials.secretName | quote }}
                  key: {{ .Values.ollama.hfToken.credentials.key | default "token" | quote }}
{{- else if .Values.ollama.hfToken.token }}
            - name: HF_TOKEN
              value: {{ .Values.ollama.hfToken.token | quote }}
            # Compatibility: many HF clients prefer HUGGINGFACE_HUB_TOKEN
            - name: HUGGINGFACE_HUB_TOKEN
              value: {{ .Values.ollama.hfToken.token | quote }}
{{- end }}
{{- end }}
{{- end }}


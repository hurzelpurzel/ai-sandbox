{{/*
User-defined environment variables from .Values.ollama.env
*/}}
{{- define "ollama.env.user" }}
{{- range .Values.ollama.env }}
{{- if or .valueFrom (and .value (ne .value "")) }}
            - name: {{ .name }}
              {{- if .valueFrom }}
              valueFrom:
                {{- toYaml .valueFrom | nindent 16 }}
              {{- else if .value }}
              value: {{ .value | quote }}
              {{- end }}
{{- end }}
{{- end }}
{{- end }}



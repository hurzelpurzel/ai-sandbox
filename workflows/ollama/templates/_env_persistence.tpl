{{/*
Persistence-related environment variables for Ollama
Ollama uses OLLAMA_MODELS for model storage path
Always uses /models (PVC when persistence enabled, emptyDir when disabled)
*/}}
{{- define "ollama.env.persistence" }}
{{- $modelsSet := false }}
{{- $tmpdirSet := false }}
{{- $tempSet := false }}
{{- $tmpSet := false }}
{{- if .Values.ollama.modelsPath }}
{{- $modelsSet = true }}
{{- end }}
{{- range .Values.ollama.env }}
{{- if eq .name "OLLAMA_MODELS" }}{{- $modelsSet = true }}{{- end }}
{{- if eq .name "TMPDIR" }}{{- $tmpdirSet = true }}{{- end }}
{{- if eq .name "TEMP" }}{{- $tempSet = true }}{{- end }}
{{- if eq .name "TMP" }}{{- $tmpSet = true }}{{- end }}
{{- end }}
{{- if not $modelsSet }}
            - name: OLLAMA_MODELS
              value: "/models"
{{- end }}
{{- if not $tmpdirSet }}
            - name: TMPDIR
              value: "/models/tmp"
{{- end }}
{{- if not $tempSet }}
            - name: TEMP
              value: "/models/tmp"
{{- end }}
{{- if not $tmpSet }}
            - name: TMP
              value: "/models/tmp"
{{- end }}
{{- end }}



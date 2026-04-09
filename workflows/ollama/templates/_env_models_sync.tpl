{{/*
OLLAMA_SYNC_RETAIN_MODELS_JSON: JSON array of model names the custom entrypoint should never prune
via chart-driven sync (union of models.pull, derived names, and derived bases).
*/}}
{{- define "ollama.env.modelsSync" }}
            - name: OLLAMA_SYNC_RETAIN_MODELS_JSON
              value: {{ include "ollama.syncRetainModelsJSON" . | quote }}
{{- end }}

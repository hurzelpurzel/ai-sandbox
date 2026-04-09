{{/*
Chart-derived models are applied only by the Ollama image entrypoint (no Helm hook Job).
See ENTRYPOINT_DERIVED_MODELS_SPEC.md.
*/}}
{{- define "ollama.env.derivedModels" }}
            - name: OLLAMA_DERIVED_MODELS_SYNC
              value: "entrypoint"
            {{- $manifest := trim (include "ollama.derivedModelsManifestJSON" .) }}
            {{- if ne $manifest "[]" }}
            - name: OLLAMA_DERIVED_MODELS_FILE
              value: "/etc/ollama/chart-derived-models/derived-models.json"
            {{- end }}
{{- end }}

{{/*
Mount chart-derived-models.json when the rendered derived manifest is non-empty
(at least one derivedModels[] row whose `from` is in models.pull).
*/}}
{{- define "ollama.volumeMounts.derivedModels" }}
{{- $manifest := trim (include "ollama.derivedModelsManifestJSON" .) }}
{{- if ne $manifest "[]" }}
- name: chart-derived-models
  mountPath: /etc/ollama/chart-derived-models
  readOnly: true
{{- end }}
{{- end }}

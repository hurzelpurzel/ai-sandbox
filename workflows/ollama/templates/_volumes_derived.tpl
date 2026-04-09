{{/*
ConfigMap volume for derived-models.json.
*/}}
{{- define "ollama.volumes.derivedModels" }}
{{- $manifest := trim (include "ollama.derivedModelsManifestJSON" .) }}
{{- if ne $manifest "[]" }}
- name: chart-derived-models
  configMap:
    name: {{ include "ollama.fullname" . }}-chart-derived-models
    defaultMode: 0444
{{- end }}
{{- end }}

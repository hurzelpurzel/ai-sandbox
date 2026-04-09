{{/*
JSON array of objects: { "name", "from", "modelfile" } for the Ollama image entrypoint.
name is values ollama.models.derivedModels[].name with -<Release.Namespace> suffix (see ollama.derivedModelNameWithNamespaceSuffix).
modelfile is full Modelfile text (FROM + PARAMETER lines) from ollama.derivedModelfile.
Only rows whose `from` is listed in ollama.models.pull (exact string match) are included.
*/}}
{{- define "ollama.derivedModelsManifestJSON" -}}
{{- $root := . }}
{{- $m := dict }}
{{- if and .Values.ollama .Values.ollama.models }}{{- $m = .Values.ollama.models }}{{- end }}
{{- $pullSet := dict }}
{{- range $p := ($m.pull | default list) }}
{{- $_ := set $pullSet (printf "%v" $p) "1" }}
{{- end }}
{{- $acc := list -}}
{{- range $d := ($m.derivedModels | default list) -}}
{{- if and $d.from (hasKey $pullSet $d.from) -}}
{{- $mn := include "ollama.derivedModelNameWithNamespaceSuffix" (dict "name" $d.name "namespace" $root.Release.Namespace) -}}
{{- $mf := include "ollama.derivedModelfile" $d | trim -}}
{{- $acc = concat $acc (list (dict "name" $mn "from" $d.from "modelfile" $mf)) -}}
{{- end -}}
{{- end -}}
{{- $acc | toJson -}}
{{- end -}}

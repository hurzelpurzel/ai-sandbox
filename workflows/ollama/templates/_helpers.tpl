{{/*
Expand the name of the chart.
*/}}
{{- define "ollama.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ollama.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ollama.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ollama.labels" -}}
helm.sh/chart: {{ include "ollama.chart" . }}
{{ include "ollama.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ollama.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ollama.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ollama.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ollama.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Effective Ollama model name for a derivedModels[] row: append -<namespace> so the same values.name can be deployed in multiple namespaces without colliding.
If values name contains ":", treat as model:tag and append the suffix to the tag (e.g. gpt-oss:20b-validator + ns ollama6 -> gpt-oss:20b-validator-ollama6).
Otherwise append -<namespace> to the whole string.
*/}}
{{- define "ollama.derivedModelNameWithNamespaceSuffix" -}}
{{- $name := .name -}}
{{- $ns := .namespace -}}
{{- $parts := splitList ":" $name -}}
{{- if gt (len $parts) 1 -}}
{{- $model := index $parts 0 -}}
{{- $tag := join ":" (rest $parts) -}}
{{- printf "%s:%s-%s" $model $tag $ns -}}
{{- else -}}
{{- printf "%s-%s" $name $ns -}}
{{- end -}}
{{- end -}}

{{/*
Unique model names to retain during entrypoint cache sync: pull ∪ derived effective name ∪ derived.from
(for derived rows whose `from` is in pull only — same filter as derived-models.json).
Emits a JSON array of strings (UTF-8), sorted for stable renders.
*/}}
{{- define "ollama.syncRetainModelsJSON" -}}
{{- $retain := dict }}
{{- $models := dict }}
{{- if and .Values.ollama .Values.ollama.models }}
{{- $models = .Values.ollama.models }}
{{- end }}
{{- $pullSet := dict }}
{{- range $p := ($models.pull | default list) }}
{{- $_ := set $retain $p "1" }}
{{- $_ := set $pullSet (printf "%v" $p) "1" }}
{{- end }}
{{- range $d := ($models.derivedModels | default list) }}
{{- if and $d.from (hasKey $pullSet $d.from) }}
{{- $mn := include "ollama.derivedModelNameWithNamespaceSuffix" (dict "name" $d.name "namespace" $.Release.Namespace) }}
{{- $_ := set $retain $mn "1" }}
{{- $_ := set $retain $d.from "1" }}
{{- end }}
{{- end }}
{{- keys $retain | sortAlpha | toJson }}
{{- end }}

{{/*
Minimal Modelfile for one derivedModels[] entry (FROM + PARAMETER lines only).
Parameter keys are emitted in sorted order for deterministic upgrades.
*/}}
{{- define "ollama.derivedModelfile" -}}
FROM {{ .from }}
{{- if .parameters }}
{{- $p := .parameters }}
{{- range $k := sortAlpha (keys $p) }}
{{- $v := index $p $k }}
{{- if eq $k "stop" }}
{{- if kindIs "slice" $v }}
{{- range $s := $v }}
PARAMETER stop {{ $s }}
{{- end }}
{{- else }}
PARAMETER stop {{ $v }}
{{- end }}
{{- else }}
PARAMETER {{ $k }} {{ $v }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

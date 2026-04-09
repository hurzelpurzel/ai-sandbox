{{/*
Resource limits and requests for the Ollama container
Supports both nvidia.com/gpu and gpu resource types.
Omits any resource whose value is empty or null so we never emit invalid K8s quantities
(quantities must match '^([+-]?[0-9.]+)([eEinumkKMGTP]*[-+]?[0-9]*)$' - empty string is invalid).
*/}}
{{- define "ollama.resources" }}
  {{- $resources := .Values.resources }}
  {{- $limits := $resources.limits }}
  {{- $requests := $resources.requests }}
  
  {{- /* Determine GPU resource type - default to nvidia.com/gpu, but support gpu as well */}}
  {{- $gpuResourceType := "nvidia.com/gpu" }}
  {{- if .Values.resources.gpuResourceType }}
    {{- $gpuResourceType = .Values.resources.gpuResourceType }}
  {{- end }}
  
  {{- /* Process limits - support both gpu and nvidia.com/gpu; omit empty cpu/memory/ephemeral-storage */}}
  {{- if $limits }}
    {{- /* If nvidia.com/gpu is specified directly, use it as-is (don't remap) */}}
    {{- if hasKey $limits "nvidia.com/gpu" }}
      {{- $gpuLimit := index $limits "nvidia.com/gpu" }}
      {{- if or (eq $gpuLimit "") (not $gpuLimit) }}
        {{- $limits = omit $limits "nvidia.com/gpu" }}
      {{- end }}
    {{- /* If gpu key is specified, map it to gpuResourceType */}}
    {{- else if hasKey $limits "gpu" }}
      {{- $gpuLimit := index $limits "gpu" }}
      {{- $limits = omit $limits "gpu" }}
      {{- if and $gpuLimit (ne $gpuLimit "") }}
        {{- $limits = set $limits $gpuResourceType $gpuLimit }}
      {{- end }}
    {{- end }}
    {{- /* Always omit legacy 'gpu' when empty: defaults have gpu: "" and we only process the gpu branch when nvidia.com/gpu is absent; if user sets nvidia.com/gpu, gpu: "" is never stripped and gets rendered → K8s quantity error */}}
    {{- if hasKey $limits "gpu" }}
      {{- $gv := index $limits "gpu" }}
      {{- if or (eq $gv "") (eq (toString $gv) "") (eq $gv "\"\"") (eq (toString $gv) "\"\"") (not $gv) }}
        {{- $limits = omit $limits "gpu" }}
      {{- end }}
    {{- end }}
    {{- /* Omit cpu, memory, ephemeral-storage when empty or invalid (K8s rejects "" and '""' as quantity) */}}
    {{- $cv := index $limits "cpu" }}
    {{- if and (hasKey $limits "cpu") (or (eq $cv "") (eq (toString $cv) "") (eq $cv "\"\"") (eq (toString $cv) "\"\"")) }}
      {{- $limits = omit $limits "cpu" }}
    {{- end }}
    {{- $mv := index $limits "memory" }}
    {{- if and (hasKey $limits "memory") (or (eq $mv "") (eq (toString $mv) "") (eq $mv "\"\"") (eq (toString $mv) "\"\"")) }}
      {{- $limits = omit $limits "memory" }}
    {{- end }}
    {{- $ev := index $limits "ephemeral-storage" }}
    {{- if and (hasKey $limits "ephemeral-storage") (or (eq $ev "") (eq (toString $ev) "") (eq $ev "\"\"") (eq (toString $ev) "\"\"")) }}
      {{- $limits = omit $limits "ephemeral-storage" }}
    {{- end }}
  {{- end }}
  
  {{- /* Process requests - support both gpu and nvidia.com/gpu; omit empty cpu/memory/ephemeral-storage */}}
  {{- if $requests }}
    {{- /* If nvidia.com/gpu is specified directly, use it as-is (don't remap) */}}
    {{- if hasKey $requests "nvidia.com/gpu" }}
      {{- $gpuRequest := index $requests "nvidia.com/gpu" }}
      {{- if or (eq $gpuRequest "") (not $gpuRequest) }}
        {{- $requests = omit $requests "nvidia.com/gpu" }}
      {{- end }}
    {{- /* If gpu key is specified, map it to gpuResourceType */}}
    {{- else if hasKey $requests "gpu" }}
      {{- $gpuRequest := index $requests "gpu" }}
      {{- $requests = omit $requests "gpu" }}
      {{- if and $gpuRequest (ne $gpuRequest "") }}
        {{- $requests = set $requests $gpuResourceType $gpuRequest }}
      {{- end }}
    {{- end }}
    {{- /* Always omit legacy 'gpu' when empty (same as limits: default gpu: "" can remain when user sets nvidia.com/gpu) */}}
    {{- if hasKey $requests "gpu" }}
      {{- $gv := index $requests "gpu" }}
      {{- if or (eq $gv "") (eq (toString $gv) "") (eq $gv "\"\"") (eq (toString $gv) "\"\"") (not $gv) }}
        {{- $requests = omit $requests "gpu" }}
      {{- end }}
    {{- end }}
    {{- /* Omit cpu, memory, ephemeral-storage when empty or invalid (K8s rejects "" and '""' as quantity) */}}
    {{- $cv := index $requests "cpu" }}
    {{- if and (hasKey $requests "cpu") (or (eq $cv "") (eq (toString $cv) "") (eq $cv "\"\"") (eq (toString $cv) "\"\"")) }}
      {{- $requests = omit $requests "cpu" }}
    {{- end }}
    {{- $mv := index $requests "memory" }}
    {{- if and (hasKey $requests "memory") (or (eq $mv "") (eq (toString $mv) "") (eq $mv "\"\"") (eq (toString $mv) "\"\"")) }}
      {{- $requests = omit $requests "memory" }}
    {{- end }}
    {{- $ev := index $requests "ephemeral-storage" }}
    {{- if and (hasKey $requests "ephemeral-storage") (or (eq $ev "") (eq (toString $ev) "") (eq $ev "\"\"") (eq (toString $ev) "\"\"")) }}
      {{- $requests = omit $requests "ephemeral-storage" }}
    {{- end }}
  {{- end }}
  
  {{- $filteredResources := dict "limits" $limits "requests" $requests }}
  {{- toYaml $filteredResources | nindent 12 }}
{{- end }}

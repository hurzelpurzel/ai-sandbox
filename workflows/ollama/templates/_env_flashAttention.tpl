{{/*
Flash Attention environment variables
*/}}
{{- define "ollama.env.flashAttention" }}
{{- if .Values.hardware.blackwell.supported }}
{{- if .Values.ollama.flashAttention }}
{{- $version := .Values.ollama.flashAttention.version | int }}
{{- if eq $version 2 }}
- name: VLLM_FLASH_ATTN_VERSION
  value: "{{ $version }}"
{{- end }}
{{- end }}
{{- end }}
{{- end }}



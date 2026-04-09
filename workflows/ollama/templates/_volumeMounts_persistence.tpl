{{/*
Persistence-related volume mounts (model-storage, quant-models, .ollama home directory)
Always mounts /models (PVC when persistence enabled, emptyDir when disabled)
Also mounts /home/ollama/.ollama for Ollama's internal files (SSH keys, config, etc.)
*/}}
{{- define "ollama.volumeMounts.persistence" }}
- name: model-storage
  mountPath: /models
# Mount .ollama directory to home directory (Ollama creates SSH keys and config here)
- name: model-storage
  mountPath: /home/ollama/.ollama
  subPath: .ollama
  readOnly: false
{{- if .Values.ollama.quantization }}
{{- if .Values.ollama.quantization.enabled }}
{{- if or (eq .Values.ollama.quantization.type "gguf") (eq .Values.ollama.quantization.type "gptq") (eq .Values.ollama.quantization.type "awq") }}
- name: quant-models
  mountPath: /models/quant
{{- end }}
{{- end }}
{{- end }}
{{- end }}


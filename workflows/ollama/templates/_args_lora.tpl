{{/*
LoRA arguments (legacy - use loraConfig for full support)
*/}}
{{- define "ollama.args.lora" }}
            {{- if .Values.ollama.lora }}
            {{- if .Values.ollama.lora.enabled }}
            {{- if .Values.ollama.lora.modules }}
            {{- $modules := join ":" .Values.ollama.lora.modules }}
            - "--lora-modules"
            - {{ $modules | quote }}
            {{- end }}
            - "--enable-lora"
            {{- end }}
            {{- end }}
            {{- if and .Values.ollama.lora (not .Values.ollama.loraConfig) }}
            {{- if .Values.ollama.lora.modules }}
            {{- range .Values.ollama.lora.modules }}
            - "--lora-modules"
            - {{ . | quote }}
            {{- end }}
            {{- end }}
            {{- end }}
{{- end }}


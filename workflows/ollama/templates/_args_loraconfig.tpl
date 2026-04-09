{{/*
LoRAConfig arguments for ollama serve
Configuration for LoRA
*/}}
{{- define "ollama.args.loraconfig" }}
{{- if .Values.ollama.loraConfig }}
{{- if .Values.ollama.loraConfig.defaultMmLoras }}
            - "--default-mm-loras"
            - {{ .Values.ollama.loraConfig.defaultMmLoras | quote }}
{{- end }}
{{- if ne .Values.ollama.loraConfig.enableLora nil }}
            {{- if .Values.ollama.loraConfig.enableLora }}
            - "--enable-lora"
            {{- else }}
            - "--no-enable-lora"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.loraConfig.fullyShardedLoras nil }}
            {{- if .Values.ollama.loraConfig.fullyShardedLoras }}
            - "--fully-sharded-loras"
            {{- else }}
            - "--no-fully-sharded-loras"
            {{- end }}
{{- end }}
{{- if and .Values.ollama.loraConfig.loraDtype (ne .Values.ollama.loraConfig.loraDtype "") }}
            - "--lora-dtype"
            - {{ .Values.ollama.loraConfig.loraDtype | quote }}
{{- end }}
{{- if .Values.ollama.loraConfig.loraExtraVocabSize }}
            - "--lora-extra-vocab-size"
            - {{ .Values.ollama.loraConfig.loraExtraVocabSize | quote }}
{{- end }}
{{- if .Values.ollama.loraConfig.maxCpuLoras }}
            - "--max-cpu-loras"
            - {{ .Values.ollama.loraConfig.maxCpuLoras | quote }}
{{- end }}
{{- if .Values.ollama.loraConfig.maxLoraRank }}
            - "--max-lora-rank"
            - {{ .Values.ollama.loraConfig.maxLoraRank | quote }}
{{- end }}
{{- if .Values.ollama.loraConfig.maxLoras }}
            - "--max-loras"
            - {{ .Values.ollama.loraConfig.maxLoras | quote }}
{{- end }}
{{- end }}
{{- end }}


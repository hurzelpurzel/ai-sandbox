{{/*
LoadConfig arguments for ollama serve
Configuration for loading the model weights
*/}}
{{- define "ollama.args.loadconfig" }}
{{- if .Values.ollama.loadConfig }}
{{- if and .Values.ollama.loadConfig.downloadDir (ne .Values.ollama.loadConfig.downloadDir "") }}
            - "--download-dir"
            - {{ .Values.ollama.loadConfig.downloadDir | quote }}
{{- end }}
{{- if and .Values.ollama.loadConfig.ignorePatterns (gt (len .Values.ollama.loadConfig.ignorePatterns) 0) }}
            - "--ignore-patterns"
            {{- range .Values.ollama.loadConfig.ignorePatterns }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if and .Values.ollama.loadConfig.loadFormat (ne .Values.ollama.loadConfig.loadFormat "") }}
            - "--load-format"
            - {{ .Values.ollama.loadConfig.loadFormat | quote }}
{{- end }}
{{- if .Values.ollama.loadConfig.modelLoaderExtraConfig }}
            - "--model-loader-extra-config"
            - {{ .Values.ollama.loadConfig.modelLoaderExtraConfig | quote }}
{{- end }}
{{- if and .Values.ollama.loadConfig.ptLoadMapLocation (ne .Values.ollama.loadConfig.ptLoadMapLocation "") }}
            - "--pt-load-map-location"
            - {{ .Values.ollama.loadConfig.ptLoadMapLocation | quote }}
{{- end }}
{{- if and .Values.ollama.loadConfig.safetensorsLoadStrategy (ne .Values.ollama.loadConfig.safetensorsLoadStrategy "") }}
            - "--safetensors-load-strategy"
            - {{ .Values.ollama.loadConfig.safetensorsLoadStrategy | quote }}
{{- end }}
{{- if ne .Values.ollama.loadConfig.useTqdmOnLoad nil }}
            {{- if .Values.ollama.loadConfig.useTqdmOnLoad }}
            - "--use-tqdm-on-load"
            {{- else }}
            - "--no-use-tqdm-on-load"
            {{- end }}
{{- else }}
            # useTqdmOnLoad not explicitly set - defaulting to --use-tqdm-on-load (OLLAMA default: True)
            - "--use-tqdm-on-load"
{{- end }}
{{- end }}
{{- end }}


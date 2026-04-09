{{/*
CompilationConfig arguments for ollama serve
Configuration for compilation
*/}}
{{- define "ollama.args.compilationconfig" }}
{{- if .Values.ollama.compilationConfig }}
{{- if .Values.ollama.compilationConfig.cudaGraphSizes }}
            - "--cuda-graph-sizes"
            {{- range .Values.ollama.compilationConfig.cudaGraphSizes }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if .Values.ollama.compilationConfig.cudagraphCaptureSizes }}
            - "--cudagraph-capture-sizes"
            {{- range .Values.ollama.compilationConfig.cudagraphCaptureSizes }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if .Values.ollama.compilationConfig.maxCudagraphCaptureSize }}
            - "--max-cudagraph-capture-size"
            - {{ .Values.ollama.compilationConfig.maxCudagraphCaptureSize | quote }}
{{- end }}
{{- if .Values.ollama.compilationConfig.compilationConfig }}
            - "--compilation-config"
            - {{ if kindIs "string" .Values.ollama.compilationConfig.compilationConfig }}{{ .Values.ollama.compilationConfig.compilationConfig | quote }}{{ else }}{{ .Values.ollama.compilationConfig.compilationConfig | toJson | quote }}{{ end }}
{{- end }}
{{- end }}
{{- end }}


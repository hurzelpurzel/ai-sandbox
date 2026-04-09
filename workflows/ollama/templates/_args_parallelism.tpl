{{/*
Parallelism arguments (tensor, pipeline) - legacy, use parallelConfig for full support
*/}}
{{- define "ollama.args.parallelism" }}
            {{- if and .Values.ollama.parallelism (not .Values.ollama.parallelConfig) }}
            {{- if or .Values.ollama.parallelism.tensor .Values.ollama.parallelism.pipeline }}
            {{- if .Values.ollama.parallelism.tensor }}
            - "--tensor-parallel-size"
            - {{ .Values.ollama.parallelism.tensor | int | quote }}
            {{- end }}
            {{- if .Values.ollama.parallelism.pipeline }}
            - "--pipeline-parallel-size"
            - {{ .Values.ollama.parallelism.pipeline | int | quote }}
            {{- end }}
            {{- end }}
            {{- end }}
            {{- if and .Values.ollama.parallelConfig (not .Values.ollama.parallelism) }}
            {{- if .Values.ollama.parallelConfig.tensorParallelSize }}
            - "--tensor-parallel-size"
            - {{ .Values.ollama.parallelConfig.tensorParallelSize | int | quote }}
            {{- end }}
            {{- if .Values.ollama.parallelConfig.pipelineParallelSize }}
            - "--pipeline-parallel-size"
            - {{ .Values.ollama.parallelConfig.pipelineParallelSize | int | quote }}
            {{- end }}
            {{- end }}
{{- end }}


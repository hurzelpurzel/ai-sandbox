{{/*
Scheduler arguments (legacy - use schedulerConfig for full support)
*/}}
{{- define "ollama.args.scheduler" }}
            {{- if and .Values.ollama.scheduler (ne .Values.ollama.scheduler nil) (not .Values.ollama.schedulerConfig) }}
            {{- if or .Values.ollama.scheduler.policy .Values.ollama.scheduler.maxBatchedTokens .Values.ollama.scheduler.maxNumSeqs }}
            {{- if .Values.ollama.scheduler.policy }}
            - "--scheduling-policy"
            - {{ .Values.ollama.scheduler.policy | quote }}
            {{- end }}
            {{- if .Values.ollama.scheduler.maxBatchedTokens }}
            - "--max-num-batched-tokens"
            - {{ .Values.ollama.scheduler.maxBatchedTokens | int | quote }}
            {{- end }}
            {{- if .Values.ollama.scheduler.maxNumSeqs }}
            - "--max-num-seqs"
            - {{ .Values.ollama.scheduler.maxNumSeqs | int | quote }}
            {{- end }}
            {{- end }}
            {{- end }}
{{- end }}


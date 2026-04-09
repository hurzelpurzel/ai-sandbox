{{/*
Common OLLAMA arguments for ollama serve (host, port, gpu-memory, max-model-len, trust-remote-code)
All arguments are compatible with ollama serve command
*/}}
{{- define "ollama.args.common" }}
            - "--host"
            - {{ .Values.ollama.host | quote }}
            - "--port"
            - {{ .Values.ollama.port | quote }}
            - "--gpu-memory-utilization"
            - {{ .Values.ollama.gpuMemoryUtilization | quote }}
            # Note: maxModelLen is global in OLLAMA CLI, but we allow per-model specification
            # In multi-model mode, we use the maximum maxModelLen found across all models
            # This ensures all models can work (though some may have unused capacity)
            # Otherwise, use the global maxModelLen
            - "--max-model-len"
            - {{ include "ollama.args.maxModelLen" . | quote }}
            # trust-remote-code: Check if any model needs it (per-model setting, GPTQ, AWQ, or global)
            {{- if include "ollama.args.trustRemoteCode" . }}
            - "--trust-remote-code"
            {{- end }}
{{- end }}


{{/*
Model arguments (multi-model vs single-model)
With ollama serve:
- Single model: use positional argument (ollama serve <model>)
- Multi-model: use --model flag for each model (ollama serve --model <model1> --model <model2>)
*/}}
{{- define "ollama.args.model" }}
{{- if .Values.ollama.multiModel }}
{{- range $model := .Values.ollama.models }}
            # Multi-model: use --model flag for each model
            - "--model"
            - {{ $model.name | quote }}
            # Backend override
            {{- if $model.backend }}
            - "--model-impl"
            - {{ $model.backend | quote }}
            {{- end }}
            # Per-model quantization
            # Note: Per-model maxModelLen is specified in the model config but applied globally
            # OLLAMA CLI doesn't support per-model maxModelLen, so we use the first specified value
            {{- if $model.quantization }}
            {{- include "ollama.args.quantization" (dict "quantization" $model.quantization "context" $) | nindent 12 }}
            {{- end }}
            {{- end }}
{{- else }}
            # Single model: use positional argument (ollama serve <model>)
            - {{ .Values.ollama.model | quote }}
{{- end }}
{{- end }}


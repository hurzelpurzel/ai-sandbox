{{/*
MultiModalConfig arguments for ollama serve
Controls the behavior of multimodal models
*/}}
{{- define "ollama.args.multimodalconfig" }}
{{- if .Values.ollama.multiModalConfig }}
{{- if ne .Values.ollama.multiModalConfig.disableMmPreprocessorCache nil }}
            {{- if .Values.ollama.multiModalConfig.disableMmPreprocessorCache }}
            - "--disable-mm-preprocessor-cache"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.multiModalConfig.enableMmEmbeds nil }}
            {{- if .Values.ollama.multiModalConfig.enableMmEmbeds }}
            - "--enable-mm-embeds"
            {{- else }}
            - "--no-enable-mm-embeds"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.multiModalConfig.interleaveMmStrings nil }}
            {{- if .Values.ollama.multiModalConfig.interleaveMmStrings }}
            - "--interleave-mm-strings"
            {{- else }}
            - "--no-interleave-mm-strings"
            {{- end }}
{{- end }}
{{- if .Values.ollama.multiModalConfig.limitMmPerPrompt }}
            - "--limit-mm-per-prompt"
            - {{ .Values.ollama.multiModalConfig.limitMmPerPrompt | quote }}
{{- end }}
{{- if .Values.ollama.multiModalConfig.mediaIoKwargs }}
            - "--media-io-kwargs"
            - {{ .Values.ollama.multiModalConfig.mediaIoKwargs | quote }}
{{- end }}
{{- if .Values.ollama.multiModalConfig.mmEncoderAttnBackend }}
            - "--mm-encoder-attn-backend"
            - {{ .Values.ollama.multiModalConfig.mmEncoderAttnBackend | quote }}
{{- end }}
{{- if and .Values.ollama.multiModalConfig.mmEncoderTpMode (ne .Values.ollama.multiModalConfig.mmEncoderTpMode "") }}
            - "--mm-encoder-tp-mode"
            - {{ .Values.ollama.multiModalConfig.mmEncoderTpMode | quote }}
{{- end }}
{{- if .Values.ollama.multiModalConfig.mmProcessorCacheGb }}
            - "--mm-processor-cache-gb"
            - {{ .Values.ollama.multiModalConfig.mmProcessorCacheGb | quote }}
{{- end }}
{{- if and .Values.ollama.multiModalConfig.mmProcessorCacheType (ne .Values.ollama.multiModalConfig.mmProcessorCacheType "") }}
            - "--mm-processor-cache-type"
            - {{ .Values.ollama.multiModalConfig.mmProcessorCacheType | quote }}
{{- end }}
{{- if .Values.ollama.multiModalConfig.mmProcessorKwargs }}
            - "--mm-processor-kwargs"
            - {{ .Values.ollama.multiModalConfig.mmProcessorKwargs | quote }}
{{- end }}
{{- if .Values.ollama.multiModalConfig.mmShmCacheMaxObjectSizeMb }}
            - "--mm-shm-cache-max-object-size-mb"
            - {{ .Values.ollama.multiModalConfig.mmShmCacheMaxObjectSizeMb | quote }}
{{- end }}
{{- if ne .Values.ollama.multiModalConfig.skipMmProfiling nil }}
            {{- if .Values.ollama.multiModalConfig.skipMmProfiling }}
            - "--skip-mm-profiling"
            {{- else }}
            - "--no-skip-mm-profiling"
            {{- end }}
{{- end }}
{{- if .Values.ollama.multiModalConfig.videoPruningRate }}
            - "--video-pruning-rate"
            - {{ .Values.ollama.multiModalConfig.videoPruningRate | quote }}
{{- end }}
{{- end }}
{{- end }}


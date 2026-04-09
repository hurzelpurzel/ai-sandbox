{{/*
ModelConfig arguments for ollama serve
Configuration for the model
*/}}
{{- define "ollama.args.modelconfig" }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.dtype (ne .Values.ollama.modelConfig.dtype "") }}
            - "--dtype"
            - {{ .Values.ollama.modelConfig.dtype | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.revision (ne .Values.ollama.modelConfig.revision "") }}
            - "--revision"
            - {{ .Values.ollama.modelConfig.revision | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.codeRevision (ne .Values.ollama.modelConfig.codeRevision "") }}
            - "--code-revision"
            - {{ .Values.ollama.modelConfig.codeRevision | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.tokenizer (ne .Values.ollama.modelConfig.tokenizer "") }}
            - "--tokenizer"
            - {{ .Values.ollama.modelConfig.tokenizer | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.tokenizerRevision (ne .Values.ollama.modelConfig.tokenizerRevision "") }}
            - "--tokenizer-revision"
            - {{ .Values.ollama.modelConfig.tokenizerRevision | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.tokenizerMode (ne .Values.ollama.modelConfig.tokenizerMode "") }}
            - "--tokenizer-mode"
            - {{ .Values.ollama.modelConfig.tokenizerMode | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.hfConfigPath (ne .Values.ollama.modelConfig.hfConfigPath "") }}
            - "--hf-config-path"
            - {{ .Values.ollama.modelConfig.hfConfigPath | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.hfToken }}
            - "--hf-token"
            {{- if eq .Values.ollama.modelConfig.hfToken true }}
            - "true"
            {{- else }}
            - {{ .Values.ollama.modelConfig.hfToken | quote }}
            {{- end }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.seed (ne .Values.ollama.modelConfig.seed "") }}
            - "--seed"
            - {{ .Values.ollama.modelConfig.seed | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.servedModelName (gt (len .Values.ollama.modelConfig.servedModelName) 0) }}
            - "--served-model-name"
            {{- range .Values.ollama.modelConfig.servedModelName }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.modelConfig.enablePromptEmbeds nil }}
            {{- if .Values.ollama.modelConfig.enablePromptEmbeds }}
            - "--enable-prompt-embeds"
            {{- else }}
            - "--no-enable-prompt-embeds"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.modelConfig.enableSleepMode nil }}
            {{- if .Values.ollama.modelConfig.enableSleepMode }}
            - "--enable-sleep-mode"
            {{- else }}
            - "--no-enable-sleep-mode"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.modelConfig.enforceEager nil }}
            {{- if .Values.ollama.modelConfig.enforceEager }}
            - "--enforce-eager"
            {{- else }}
            - "--no-enforce-eager"
            {{- end }}
{{- else }}
            # enforceEager not explicitly set - defaulting to --enforce-eager
            - "--enforce-eager"
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.generationConfig (ne .Values.ollama.modelConfig.generationConfig "") }}
            - "--generation-config"
            - {{ .Values.ollama.modelConfig.generationConfig | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.maxLogprobs (ne .Values.ollama.modelConfig.maxLogprobs "") }}
            - "--max-logprobs"
            - {{ .Values.ollama.modelConfig.maxLogprobs | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.logprobsMode (ne .Values.ollama.modelConfig.logprobsMode "") }}
            - "--logprobs-mode"
            - {{ .Values.ollama.modelConfig.logprobsMode | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.runner (ne .Values.ollama.modelConfig.runner "") }}
            - "--runner"
            - {{ .Values.ollama.modelConfig.runner | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.allowedLocalMediaPath (ne .Values.ollama.modelConfig.allowedLocalMediaPath "") }}
            - "--allowed-local-media-path"
            - {{ .Values.ollama.modelConfig.allowedLocalMediaPath | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.allowedMediaDomains (gt (len .Values.ollama.modelConfig.allowedMediaDomains) 0) }}
            - "--allowed-media-domains"
            {{- range .Values.ollama.modelConfig.allowedMediaDomains }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.configFormat (ne .Values.ollama.modelConfig.configFormat "") }}
            - "--config-format"
            - {{ .Values.ollama.modelConfig.configFormat | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.convert (ne .Values.ollama.modelConfig.convert "") }}
            - "--convert"
            - {{ .Values.ollama.modelConfig.convert | quote }}
{{- end }}
{{- if ne .Values.ollama.modelConfig.disableCascadeAttn nil }}
            {{- if .Values.ollama.modelConfig.disableCascadeAttn }}
            - "--disable-cascade-attn"
            {{- else }}
            - "--no-disable-cascade-attn"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.modelConfig.disableSlidingWindow nil }}
            {{- if .Values.ollama.modelConfig.disableSlidingWindow }}
            - "--disable-sliding-window"
            {{- else }}
            - "--no-disable-sliding-window"
            {{- end }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.hfOverrides }}
            - "--hf-overrides"
            - {{ .Values.ollama.modelConfig.hfOverrides | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.ioProcessorPlugin }}
            - "--io-processor-plugin"
            - {{ .Values.ollama.modelConfig.ioProcessorPlugin | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.logitsProcessorPattern }}
            - "--logits-processor-pattern"
            - {{ .Values.ollama.modelConfig.logitsProcessorPattern | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.logitsProcessors (gt (len .Values.ollama.modelConfig.logitsProcessors) 0) }}
            - "--logits-processors"
            {{- range .Values.ollama.modelConfig.logitsProcessors }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.overrideAttentionDtype }}
            - "--override-attention-dtype"
            - {{ .Values.ollama.modelConfig.overrideAttentionDtype | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.overrideGenerationConfig }}
            - "--override-generation-config"
            - {{ .Values.ollama.modelConfig.overrideGenerationConfig | quote }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.poolerConfig }}
            - "--pooler-config"
            - {{ .Values.ollama.modelConfig.poolerConfig | quote }}
{{- end }}
{{- if ne .Values.ollama.modelConfig.skipTokenizerInit nil }}
            {{- if .Values.ollama.modelConfig.skipTokenizerInit }}
            - "--skip-tokenizer-init"
            {{- else }}
            - "--no-skip-tokenizer-init"
            {{- end }}
{{- end }}
{{- if and .Values.ollama.modelConfig .Values.ollama.modelConfig.task (ne .Values.ollama.modelConfig.task "") }}
            - "--task"
            - {{ .Values.ollama.modelConfig.task | quote }}
{{- end }}
{{- end }}


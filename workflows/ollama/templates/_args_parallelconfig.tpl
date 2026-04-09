{{/*
ParallelConfig arguments for ollama serve
Configuration for the distributed execution
*/}}
{{- define "ollama.args.parallelconfig" }}
{{- if .Values.ollama.parallelConfig }}
{{- if .Values.ollama.parallelConfig.all2allBackend }}
            - "--all2all-backend"
            - {{ .Values.ollama.parallelConfig.all2allBackend | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dataParallelAddress }}
            - "--data-parallel-address"
            - {{ .Values.ollama.parallelConfig.dataParallelAddress | quote }}
{{- end }}
{{- if and .Values.ollama.parallelConfig.dataParallelBackend (ne .Values.ollama.parallelConfig.dataParallelBackend "") }}
            - "--data-parallel-backend"
            - {{ .Values.ollama.parallelConfig.dataParallelBackend | quote }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.dataParallelExternalLb nil }}
            {{- if .Values.ollama.parallelConfig.dataParallelExternalLb }}
            - "--data-parallel-external-lb"
            {{- else }}
            - "--no-data-parallel-external-lb"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.dataParallelHybridLb nil }}
            {{- if .Values.ollama.parallelConfig.dataParallelHybridLb }}
            - "--data-parallel-hybrid-lb"
            {{- else }}
            - "--no-data-parallel-hybrid-lb"
            {{- end }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dataParallelRank }}
            - "--data-parallel-rank"
            - {{ .Values.ollama.parallelConfig.dataParallelRank | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dataParallelRpcPort }}
            - "--data-parallel-rpc-port"
            - {{ .Values.ollama.parallelConfig.dataParallelRpcPort | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dataParallelSize }}
            - "--data-parallel-size"
            - {{ .Values.ollama.parallelConfig.dataParallelSize | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dataParallelSizeLocal }}
            - "--data-parallel-size-local"
            - {{ .Values.ollama.parallelConfig.dataParallelSizeLocal | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dataParallelStartRank }}
            - "--data-parallel-start-rank"
            - {{ .Values.ollama.parallelConfig.dataParallelStartRank | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dboDecodeTokenThreshold }}
            - "--dbo-decode-token-threshold"
            - {{ .Values.ollama.parallelConfig.dboDecodeTokenThreshold | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dboPrefillTokenThreshold }}
            - "--dbo-prefill-token-threshold"
            - {{ .Values.ollama.parallelConfig.dboPrefillTokenThreshold | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.dcpKvCacheInterleaveSize }}
            - "--dcp-kv-cache-interleave-size"
            - {{ .Values.ollama.parallelConfig.dcpKvCacheInterleaveSize | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.decodeContextParallelSize }}
            - "--decode-context-parallel-size"
            - {{ .Values.ollama.parallelConfig.decodeContextParallelSize | int | quote }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.disableCustomAllReduce nil }}
            {{- if .Values.ollama.parallelConfig.disableCustomAllReduce }}
            - "--disable-custom-all-reduce"
            {{- else }}
            - "--no-disable-custom-all-reduce"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.disableNcclForDpSynchronization nil }}
            {{- if .Values.ollama.parallelConfig.disableNcclForDpSynchronization }}
            - "--disable-nccl-for-dp-synchronization"
            {{- else }}
            - "--no-disable-nccl-for-dp-synchronization"
            {{- end }}
{{- end }}
{{- if and .Values.ollama.parallelConfig.distributedExecutorBackend (ne .Values.ollama.parallelConfig.distributedExecutorBackend "") }}
            - "--distributed-executor-backend"
            - {{ .Values.ollama.parallelConfig.distributedExecutorBackend | quote }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.enableDbo nil }}
            {{- if .Values.ollama.parallelConfig.enableDbo }}
            - "--enable-dbo"
            {{- else }}
            - "--no-enable-dbo"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.enableEplb nil }}
            {{- if .Values.ollama.parallelConfig.enableEplb }}
            - "--enable-eplb"
            {{- else }}
            - "--no-enable-eplb"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.enableExpertParallel nil }}
            {{- if .Values.ollama.parallelConfig.enableExpertParallel }}
            - "--enable-expert-parallel"
            {{- else }}
            - "--no-enable-expert-parallel"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.enableMultimodalEncoderDataParallel nil }}
            {{- if .Values.ollama.parallelConfig.enableMultimodalEncoderDataParallel }}
            - "--enable-multimodal-encoder-data-parallel"
            {{- end }}
{{- end }}
{{- if .Values.ollama.parallelConfig.eplbConfig }}
            - "--eplb-config"
            - {{ .Values.ollama.parallelConfig.eplbConfig | quote }}
{{- end }}
{{- if and .Values.ollama.parallelConfig.expertPlacementStrategy (ne .Values.ollama.parallelConfig.expertPlacementStrategy "") }}
            - "--expert-placement-strategy"
            - {{ .Values.ollama.parallelConfig.expertPlacementStrategy | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.masterAddr }}
            - "--master-addr"
            - {{ .Values.ollama.parallelConfig.masterAddr | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.masterPort }}
            - "--master-port"
            - {{ .Values.ollama.parallelConfig.masterPort | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.maxParallelLoadingWorkers }}
            - "--max-parallel-loading-workers"
            - {{ .Values.ollama.parallelConfig.maxParallelLoadingWorkers | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.nnodes }}
            - "--nnodes"
            - {{ .Values.ollama.parallelConfig.nnodes | int | quote }}
{{- end }}
{{- if .Values.ollama.parallelConfig.nodeRank }}
            - "--node-rank"
            - {{ .Values.ollama.parallelConfig.nodeRank | int | quote }}
{{- end }}
{{- if ne .Values.ollama.parallelConfig.rayWorkersUseNsight nil }}
            {{- if .Values.ollama.parallelConfig.rayWorkersUseNsight }}
            - "--ray-workers-use-nsight"
            {{- else }}
            - "--no-ray-workers-use-nsight"
            {{- end }}
{{- end }}
{{- if and .Values.ollama.parallelConfig.workerCls (ne .Values.ollama.parallelConfig.workerCls "") }}
            - "--worker-cls"
            - {{ .Values.ollama.parallelConfig.workerCls | quote }}
{{- end }}
{{- if and .Values.ollama.parallelConfig.workerExtensionCls (ne .Values.ollama.parallelConfig.workerExtensionCls "") }}
            - "--worker-extension-cls"
            - {{ .Values.ollama.parallelConfig.workerExtensionCls | quote }}
{{- end }}
{{- end }}
{{- end }}


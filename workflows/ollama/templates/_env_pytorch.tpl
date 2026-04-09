{{/*
PyTorch/CUDA environment variables
*/}}
{{- define "ollama.env.pytorch" }}
{{- $pytorchAllocSet := false }}
{{- range .Values.ollama.env }}
{{- if eq .name "PYTORCH_ALLOC_CONF" }}
{{- $pytorchAllocSet = true }}
{{- end }}
{{- end }}
{{- if not $pytorchAllocSet }}
# Set PYTORCH_ALLOC_CONF to reduce memory fragmentation
# This helps with CUDA OOM errors when loading multiple models
# Only set automatically if user hasn't explicitly set it in ollama.env
- name: PYTORCH_ALLOC_CONF
  value: "expandable_segments:True"
{{- end }}
{{- $pytorchMatmulPrecisionSet := false }}
{{- range .Values.ollama.env }}
{{- if eq .name "PYTORCH_FLOAT32_MATMUL_PRECISION" }}
{{- $pytorchMatmulPrecisionSet = true }}
{{- end }}
{{- end }}
{{- if and (not $pytorchMatmulPrecisionSet) .Values.ollama.pytorch.float32MatmulPrecision }}
# Set PYTORCH_FLOAT32_MATMUL_PRECISION to control float32 matrix multiplication precision
# This environment variable should be used by the entrypoint script to call:
# torch.set_float32_matmul_precision('{{ .Values.ollama.pytorch.float32MatmulPrecision }}')
# Options: 'ieee' (full precision, slower) or 'tf32' (faster, slightly lower precision)
# Legacy values also work: 'high' (→ ieee), 'medium' (→ tf32)
# Only set automatically if user hasn't explicitly set it in ollama.env
- name: PYTORCH_FLOAT32_MATMUL_PRECISION
  value: {{ .Values.ollama.pytorch.float32MatmulPrecision | quote }}
{{- end }}
{{- $pythonWarningsSet := false }}
{{- range .Values.ollama.env }}
{{- if eq .name "PYTHONWARNINGS" }}
{{- $pythonWarningsSet = true }}
{{- end }}
{{- end }}
{{- if not $pythonWarningsSet }}
# Suppress expected FutureWarnings from transformers library
# TRANSFORMERS_CACHE deprecation, torch_dtype deprecation, etc. are expected
# Users can override this in ollama.env if they want to see all warnings
- name: PYTHONWARNINGS
  value: "ignore::FutureWarning:transformers.utils.hub,ignore::FutureWarning:transformers.models.auto"
{{- end }}
{{- $torchDynamoDisableSet := false }}
{{- range .Values.ollama.env }}
{{- if eq .name "TORCHDYNAMO_DISABLE" }}
{{- $torchDynamoDisableSet = true }}
{{- end }}
{{- end }}
{{- if and (not $torchDynamoDisableSet) .Values.ollama.pytorch.disableTorchCompile }}
# Disable torch.compile JIT compilation
# This prevents torch.compile from attempting to compile code, which can fail with:
# - Data-dependent branching errors
# - Missing compilation toolchains (gcc, clang, etc.)
# - Runtime compilation issues
# Only set automatically if user hasn't explicitly set it in ollama.env
- name: TORCHDYNAMO_DISABLE
  value: "1"
{{- end }}
{{- $tritonNoCompileSet := false }}
{{- range .Values.ollama.env }}
{{- if eq .name "TRITON_NO_COMPILE" }}
{{- $tritonNoCompileSet = true }}
{{- end }}
{{- end }}
{{- if and (not $tritonNoCompileSet) .Values.ollama.pytorch.disableTritonCompile }}
# Disable Triton kernel compilation
# This prevents Triton from attempting to compile CUDA kernels at runtime, which can fail with:
# - Missing compilation toolchains (gcc, clang, etc.)
# - Runtime compilation errors
# - Security-hardened images without build tools
# Only set automatically if user hasn't explicitly set it in ollama.env
- name: TRITON_NO_COMPILE
  value: "1"
{{- end }}
{{- end }}


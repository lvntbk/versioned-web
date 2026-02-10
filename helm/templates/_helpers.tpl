{{- define "versioned-web.name" -}}
versioned-web
{{- end -}}

{{- define "versioned-web.fullname" -}}
{{ include "versioned-web.name" . }}
{{- end -}}

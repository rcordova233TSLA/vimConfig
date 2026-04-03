" Enable PlantUML syntax highlighting in the preview
let g:mkdp_plantuml = 1
let g:markdown_fenced_languages = ['plantuml']
"Markdown server local
let g:mkdp_preview_options = {
    \ 'uml': { 'server': 'http://localhost:8080',  'imageFormat': 'svg' }
    \ }
command! StopAllMarkdownPreview bufdo if &ft == 'markdown' | execute "MarkdownPreviewStop" | update | endif

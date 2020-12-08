
call my#keymap#leader('d', '+Debug')

fu! s:enterDebugger()
  let g:dotvim#debugger#signs_save = &signcolumn
  set signcolumn=yes:4
  call vimspector#Launch()
endfu

fu! s:exitDebugger()
  let &signcolumn=g:dotvim#debugger#signs_save
  unlet g:dotvim#debugger#signs_save

  call vimspector#Reset()
endfu

" function! my#visual#selection()
function! GetCurrentSelection()
  try
    let a_save = @a
    normal! gv"ay
    return @a
  finally
    let @a = a_save
  endtry
endfunction

nnoremap                          <plug>(Debugger/Start)                    :<c-U>call <SID>enterDebugger()<cr>
nmap        <leader>d<cr>         <plug>(Debugger/Start)

nnoremap                          <plug>(Debugger/Terminate)                :<c-U>call <SID>exitDebugger()<cr>
nmap        <leader>dx            <plug>(Debugger/Terminate)


map                               <plug>(Debugger/Continue)                 <Plug>VimspectorContinue
nmap        <leader>dc            <plug>(Debugger/Continue)

map                               <plug>(Debugger/Run-To-Cursor)            <Plug>VimspectorRunToCursor
nmap        <leader>dr            <plug>(Debugger/Run-To-Cursor)


map                               <plug>(Debugger/Toggle-Breakpoint)        <Plug>VimspectorToggleBreakpoint
nmap        <leader>db            <plug>(Debugger/Toggle-Breakpoint)
nmap        <leader>d<space>      <plug>(Debugger/Toggle-Breakpoint)

nnoremap                          <plug>(Debugger/Clear-All-Breakpoints)    :<c-U>call vimspector#ClearBreakpoints()<cr>
nmap        <leader>dB            <plug>(Debugger/Clear-All-Breakpoints)

map                               <plug>(Debugger/Step-Over)                <Plug>VimspectorStepOver
nmap        <leader>do            <plug>(Debugger/Step-Over)
nmap        <leader>ds            <plug>(Debugger/Step-Over)
nmap        <leader>d;            <plug>(Debugger/Step-Over)
nmap        <leader>d<right>      <plug>(Debugger/Step-Over)

map                               <plug>(Debugger/Step-Into)                <Plug>VimspectorStepInto
nmap        <leader>di            <plug>(Debugger/Step-Into)
nmap        <leader>d.            <plug>(Debugger/Step-Into)
nmap        <leader>d<down>       <plug>(Debugger/Step-Into)

map                               <plug>(Debugger/Step-Out)                 <Plug>VimspectorStepOut
nmap        <leader>dO            <plug>(Debugger/Step-Out)
nmap        <leader>d<up>         <plug>(Debugger/Step-Out)


call my#keymap#leader('dW', '+Window')

nnoremap                          <plug>(Debugger/Window/Console)           :<c-U>VimspectorShowOutput Console<cr>
nmap        <leader>dWc           <plug>(Debugger/Window/Console)

nnoremap                          <plug>(Debugger/Window/Breakpoints)       :<c-U>call vimspector#ListBreakpoints()<cr>
nmap        <leader>dWc           <plug>(Debugger/Window/Breakpoints)

nnoremap                          <plug>(Debugger/Window/Breakpoints)       :<c-U>VimspectorToggleLog<cr>
nmap        <leader>dWl           <plug>(Debugger/Window/Breakpoints)


call my#keymap#leader('dw', '+Watch')
nnoremap                          <plug>(Debugger/Watch/Word-Under-Cursor)  :<c-U>VimspectorWatch<space><C-R><C-W><CR>
nmap        <leader>dww           <plug>(Debugger/Watch/Word-Under-Cursor)

xnoremap                          <plug>(Debugger/Watch-Selection)          :<c-U>VimspectorWatch<space><C-R>=GetCurrentSelection()<CR><CR>
xmap        <leader>dw            <plug>(Debugger/Watch-Selection)


call my#keymap#leader('dl', '+Eval')
nnoremap                          <plug>(Debugger/Eval/Word-Under-Cursor)  :<c-U>VimspectorEval<space><C-R><C-W><CR>
nmap        <leader>dee           <plug>(Debugger/Eval/Word-Under-Cursor)

xnoremap                          <plug>(Debugger/Eval/Selection)          :<c-U>VimspectorEval<space><C-R>=GetCurrentSelection()<CR><CR>
xmap        <leader>de            <plug>(Debugger/Eval/Selection)


Plug 'puremourning/vimspector'

call my#keymap#leader('d', '+Debug')

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

function! DisableBufferDiagnostic()
  echom 'disabling diagnostic'
  let b:coc_diagnostic_disable = 1
  ALEDisableBuffer
endfunction
command! DisableBufferDiagnostic call DisableBufferDiagnostic()

function! EnableBufferDiagnostic()
  echom 'enabling diagnostic'
  let b:coc_diagnostic_disable = 0
  unlet b:coc_diagnostic_disable
  ALEEnableBuffer
endfunction
command! EnableBufferDiagnostic call EnableBufferDiagnostic()

function! ToggleBufferDiagnostic()
  if get(b:, 'coc_diagnostic_disable', 0)
    call EnableBufferDiagnostic()
    echom 'bufffer diagnosting enabled'
  else
    call DisableBufferDiagnostic()
    echom 'buffer diagnostic disabled'
  end
endfunction
command! ToggleBufferDiagnostic call ToggleBufferDiagnostic()

let s:started = 0
fu! s:enterDebugger()
  echom "enterDebugger: s:started=" . s:started
  if 0 == s:started
    echom 'starting debugger'

    let s:equalalways = &equalalways
    set noequalalways

    DisableBufferDiagnostic

    let s:started = 1
  endif
endfu

fu! s:onEnterDebugger()
  set signcolumn=yes:4
endfu

fu! s:leaveDebugger()
  echom "leaveDebugger: s:started=" . s:started
  if 1 == s:started
    echom 'leaving debugger'

    let &equalalways = s:equalalways
    unlet s:equalalways

    EnableBufferDiagnostic

    let s:started = 0
  else
    echom "WARNING: exiting debugger while not in debugging state"
  endif
endfu


nnoremap                          <plug>(Toggle/Diagnostic)                 :ToggleBufferDiagnostic<cr>
nmap        <leader>Tbd           <plug>(Toggle/Diagnostic)

nnoremap                          <plug>(Buffer/Diagnostic/Enable)          :EnableBufferDiagnostic<cr>
nnoremap                          <plug>(Buffer/Diagnostic/Disable)         :DisableBufferDiagnostic<cr>

nmap                              <plug>(Debugger/Enter)                    :call <SID>enterDebugger()<cr>
nmap                              <plug>(Debugger/OnEnter)                    :call <SID>onEnterDebugger()<cr>
nnoremap                          <plug>(Debugger/Launch)                   :call vimspector#Launch()<cr>

nmap                              <plug>(Debugger/Leave)                    :call <SID>leaveDebugger()<cr>
nnoremap                          <plug>(Debugger/Reset)                    :call vimspector#Reset()<cr>



nmap                              <plug>(Debugger/Start)                    <plug>(Debugger/Enter)<plug>(Debugger/Launch)<plug>(Debugger/OnEnter)
nmap        <leader>ds            <plug>(Debugger/Start)

nmap                              <plug>(Debugger/Terminate)                <plug>(Debugger/Reset)<plug>(Debugger/Leave)
nmap        <leader>dx            <plug>(Debugger/Terminate)


nmap                              <plug>(Debugger/Continue)                 <plug>(Debugger/Enter)<Plug>VimspectorContinue
nmap        <leader>d<cr>         <plug>(Debugger/Continue)

nmap                              <plug>(Debugger/Run-To-Cursor)            <plug>(Debugger/Enter)<Plug>VimspectorRunToCursor
nmap        <leader>dr            <plug>(Debugger/Run-To-Cursor)


nmap                              <plug>(Debugger/Toggle-Breakpoint)        <Plug>VimspectorToggleBreakpoint
nmap        <leader>db            <plug>(Debugger/Toggle-Breakpoint)
nmap        <leader>d<space>      <plug>(Debugger/Toggle-Breakpoint)

nnoremap                          <plug>(Debugger/Clear-All-Breakpoints)    :call vimspector#ClearBreakpoints()<cr>
nmap        <leader>dB            <plug>(Debugger/Clear-All-Breakpoints)

nmap                              <plug>(Debugger/Step-Over)                <plug>(Debugger/Enter)<Plug>VimspectorStepOver
nmap        <leader>do            <plug>(Debugger/Step-Over)
nmap        <leader>d;            <plug>(Debugger/Step-Over)
nmap        <leader>d<right>      <plug>(Debugger/Step-Over)
nmap        <leader><right>      <plug>(Debugger/Step-Over)

nmap                              <plug>(Debugger/Step-Into)                <plug>(Debugger/Enter)<Plug>VimspectorStepInto
nmap        <leader>di            <plug>(Debugger/Step-Into)
nmap        <leader>d.            <plug>(Debugger/Step-Into)
nmap        <leader>d<down>       <plug>(Debugger/Step-Into)
nmap        <leader><down>       <plug>(Debugger/Step-Into)

nmap                              <plug>(Debugger/Step-Out)                 <plug>(Debugger/Enter)<Plug>VimspectorStepOut
nmap        <leader>dO            <plug>(Debugger/Step-Out)
nmap        <leader>d<up>         <plug>(Debugger/Step-Out)
nmap        <leader><up>         <plug>(Debugger/Step-Out)

nmap                              <plug>(Debugger/Stop)                     <Plug>VimspectorStop
nmap        <leader>d<esc>        <plug>(Debugger/Stop)


call my#keymap#leader('dW', '+Window')

nnoremap                          <plug>(Debugger/Window/Console)           :VimspectorShowOutput Console<cr>
nmap        <leader>dWc           <plug>(Debugger/Window/Console)

nnoremap                          <plug>(Debugger/Window/Breakpoints)       :call vimspector#ListBreakpoints()<cr>
nmap        <leader>dWb           <plug>(Debugger/Window/Breakpoints)

nnoremap                          <plug>(Debugger/Window/Log)               :VimspectorToggleLog<cr>
nmap        <leader>dWl           <plug>(Debugger/Window/Log)


nnoremap                          <plug>(Debugger/Watch-Word-Under-Cursor)  :VimspectorWatch<space><C-R><C-W><CR>
nmap        <leader>dw            <plug>(Debugger/Watch-Word-Under-Cursor)

xnoremap                          <plug>(Debugger/Watch-Selection)          :<C-U>VimspectorWatch<space><C-R>=GetCurrentSelection()<CR><CR>
xmap        <leader>dw            <plug>(Debugger/Watch-Selection)


nnoremap                          <plug>(Debugger/Eval-Word-Under-Cursor)  :VimspectorEval<space><C-R><C-W><CR>
nmap        <leader>de            <plug>(Debugger/Eval-Word-Under-Cursor)

xnoremap                          <plug>(Debugger/Eval-Selection)          :<C-U>VimspectorEval<space><C-R>=GetCurrentSelection()<CR><CR>
xmap        <leader>de            <plug>(Debugger/Eval-Selection)


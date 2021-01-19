Plug 'puremourning/vimspector'

call my#keymap#leader('d', '+Debug')

let s:started = 0
fu! s:enterDebugger()
  if 0 == s:started
    let s:signcolumn  = &signcolumn
    set signcolumn=yes:4

    let s:equalalways = &equalalways
    set noequalalways

    let s:started = 1
  endif
endfu

fu! s:leaveDebugger()
  echom 'leaving...'
  if 1 == s:started
    let &signcolumn  = s:signcolumn
    unlet s:signcolumn

    let &equalalways = s:equalalways
    unlet s:equalalways

    let s:started = 0
  else
    echom "WARNING: exiting debugger while not in debugging state"
  endif
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

nnoremap                          <plug>(Debugger/Enter)                    :<C-U>call <SID>enterDebugger()<cr>
nnoremap                          <plug>(Debugger/Launch)                   :<C-U>call vimspector#Launch()<cr>

nnoremap                          <plug>(Debugger/Leave)                    :<C-U>call <SID>leaveDebugger()<cr>
nnoremap                          <plug>(Debugger/Reset)                    :<C-U>call vimspector#Reset()<cr>


nmap                              <plug>(Debugger/Start)                    <plug>(Debugger/Enter)<plug>(Debugger/Launch)
nmap        <leader>ds            <plug>(Debugger/Start)

nmap                              <plug>(Debugger/Terminate)                <plug>(Debugger/Leave)<plug>(Debugger/Reset)
nmap        <leader>dx            <plug>(Debugger/Terminate)


map                               <plug>(Debugger/Continue)                 <plug>(Debugger/Enter)<Plug>VimspectorContinue
nmap        <leader>d<cr>         <plug>(Debugger/Continue)

map                               <plug>(Debugger/Run-To-Cursor)            <plug>(Debugger/Enter)<Plug>VimspectorRunToCursor
nmap        <leader>dr            <plug>(Debugger/Run-To-Cursor)


map                               <plug>(Debugger/Toggle-Breakpoint)        <Plug>VimspectorToggleBreakpoint
nmap        <leader>db            <plug>(Debugger/Toggle-Breakpoint)
nmap        <leader>d<space>      <plug>(Debugger/Toggle-Breakpoint)

nnoremap                          <plug>(Debugger/Clear-All-Breakpoints)    :<C-U>call vimspector#ClearBreakpoints()<cr>
nmap        <leader>dB            <plug>(Debugger/Clear-All-Breakpoints)

map                               <plug>(Debugger/Step-Over)                <plug>(Debugger/Enter)<Plug>VimspectorStepOver
nmap        <leader>do            <plug>(Debugger/Step-Over)
nmap        <leader>d;            <plug>(Debugger/Step-Over)
nmap        <leader>d<right>      <plug>(Debugger/Step-Over)

map                               <plug>(Debugger/Step-Into)                <plug>(Debugger/Enter)<Plug>VimspectorStepInto
nmap        <leader>di            <plug>(Debugger/Step-Into)
nmap        <leader>d.            <plug>(Debugger/Step-Into)
nmap        <leader>d<down>       <plug>(Debugger/Step-Into)

map                               <plug>(Debugger/Step-Out)                 <plug>(Debugger/Enter)<Plug>VimspectorStepOut
nmap        <leader>dO            <plug>(Debugger/Step-Out)
nmap        <leader>d<up>         <plug>(Debugger/Step-Out)

map                               <plug>(Debugger/Stop)                     <Plug>VimspectorStop
nmap        <leader>d<esc>        <plug>(Debugger/Stop)


call my#keymap#leader('dW', '+Window')

nnoremap                          <plug>(Debugger/Window/Console)           :<C-U>VimspectorShowOutput Console<cr>
nmap        <leader>dWc           <plug>(Debugger/Window/Console)

nnoremap                          <plug>(Debugger/Window/Breakpoints)       :<C-U>call vimspector#ListBreakpoints()<cr>
nmap        <leader>dWb           <plug>(Debugger/Window/Breakpoints)

nnoremap                          <plug>(Debugger/Window/Log)               :<C-U>VimspectorToggleLog<cr>
nmap        <leader>dWl           <plug>(Debugger/Window/Log)


call my#keymap#leader('dw', '+Watch')
nnoremap                          <plug>(Debugger/Watch/Word-Under-Cursor)  :<C-U>VimspectorWatch<space><C-R><C-W><CR>
nmap        <leader>dww           <plug>(Debugger/Watch/Word-Under-Cursor)

xnoremap                          <plug>(Debugger/Watch-Selection)          :<C-U>VimspectorWatch<space><C-R>=GetCurrentSelection()<CR><CR>
xmap        <leader>dw            <plug>(Debugger/Watch-Selection)


call my#keymap#leader('dl', '+Eval')
nnoremap                          <plug>(Debugger/Eval/Word-Under-Cursor)  :<C-U>VimspectorEval<space><C-R><C-W><CR>
nmap        <leader>dee           <plug>(Debugger/Eval/Word-Under-Cursor)

xnoremap                          <plug>(Debugger/Eval/Selection)          :<C-U>VimspectorEval<space><C-R>=GetCurrentSelection()<CR><CR>
xmap        <leader>de            <plug>(Debugger/Eval/Selection)


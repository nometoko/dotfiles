#!/usr/bin/env perl

$latex = 'platex %O -synctex=1 -interaction=nonstopmode %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$biber = 'biber --bblencoding=utf8 -u -U %O %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 10;
#$pdf_previewer = '"C:\Program Files\SumatraPDF\SumatraPDF.exe" -reuse-instance %O %S';
$pdf_mode = 3;
#if ($^O eq 'darwin') {
#  $pvc_view_file_via_temporary = 0;
#  $pdf_previewer = 'open -ga /Applications/Preview.app';
#} else {
#  $pdf_previewer = 'xdg-open';
#}

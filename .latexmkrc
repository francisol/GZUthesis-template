$pdf_mode = 5;
@defalut_files = ('template.tex');
$out_dir  = "out";
$xelatex = "xelatex -file-line-error -halt-on-error  -interaction=nonstopmode -no-pdf -synctex=1 %O %S";
$xdvipdfmx = "xdvipdfmx -E -o %D %O %S";
$bibtex_use = 1.5;
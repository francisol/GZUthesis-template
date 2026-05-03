$pdf_mode = 5;
@default_files = ('final_thesis.tex');
$out_dir  = "out";
$xelatex = "xelatex -file-line-error -halt-on-error  -interaction=nonstopmode -no-pdf -synctex=1 %O %S";
$xdvipdfmx = "xdvipdfmx -E -o %D %O %S";
$bibtex_use = 2;
$biber = 'biber %O %B';
add_cus_dep('nlo', 'nls', 0, 'makenomenclature');

sub makenomenclature {
    my ($base_name, $path) = fileparse($_[0]);
    my $nlo = "$out_dir/$base_name.nlo";
    my $nls = "$out_dir/$base_name.nls";
    return system("makeindex \"$nlo\" -s nomencl.ist -o \"$nls\"");
}
